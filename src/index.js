
// Chargement de la configuration depuis .env
require('dotenv').config();




const { backupPostgres } = require('./backup');
const { backupMySQL } = require('./backup-mysql');
const { backupSQLite } = require('./backup-sqlite');
const { cleanupBackups } = require('./retention');
const { sendNotification } = require('./notify');


const cron = require('node-cron');




const {
  DB_TYPE = 'postgres',
  PGHOST, PGPORT, PGUSER, PGPASSWORD, PGDATABASE,
  MYSQL_HOST, MYSQL_PORT, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE,
  SQLITE_PATH,
  BACKUP_DIR: backupDir,
  CRON_SCHEDULE: cronSchedule,
  RETENTION_DAYS: retentionDays,
  SMTP_HOST,
  SMTP_PORT,
  SMTP_USER,
  SMTP_PASS,
  NOTIFY_EMAIL
} = process.env;






async function runBackup() {
  let notifySubject, notifyText, attachmentPath = undefined;
  try {
    let filePath, msg;
    if (DB_TYPE === 'postgres') {
      if (!PGHOST || !PGPORT || !PGUSER || !PGPASSWORD || !PGDATABASE || !backupDir) throw new Error('Config Postgres manquante');
      filePath = await backupPostgres({ host: PGHOST, port: PGPORT, user: PGUSER, password: PGPASSWORD, database: PGDATABASE, backupDir });
      msg = `[${new Date().toISOString()}] Backup PostgreSQL réussi : ${filePath}`;
    } else if (DB_TYPE === 'mysql') {
      if (!MYSQL_HOST || !MYSQL_PORT || !MYSQL_USER || !MYSQL_PASSWORD || !MYSQL_DATABASE || !backupDir) throw new Error('Config MySQL manquante');
      filePath = await backupMySQL({ host: MYSQL_HOST, port: MYSQL_PORT, user: MYSQL_USER, password: MYSQL_PASSWORD, database: MYSQL_DATABASE, backupDir });
      msg = `[${new Date().toISOString()}] Backup MySQL réussi : ${filePath}`;
    } else if (DB_TYPE === 'sqlite') {
      if (!SQLITE_PATH || !backupDir) throw new Error('Config SQLite manquante');
      filePath = await backupSQLite({ sqlitePath: SQLITE_PATH, backupDir });
      msg = `[${new Date().toISOString()}] Backup SQLite réussi : ${filePath}`;
    } else {
      throw new Error('DB_TYPE non supporté');
    }
    console.log(msg);
    notifySubject = `bupy: Backup ${DB_TYPE} réussi`;
    notifyText = msg;
    attachmentPath = filePath;
    if (retentionDays && !isNaN(Number(retentionDays))) {
      const deleted = await cleanupBackups(backupDir, Number(retentionDays));
      if (deleted > 0) {
        const msg2 = `[${new Date().toISOString()}] Rétention : ${deleted} ancien(s) backup(s) supprimé(s).`;
        console.log(msg2);
        notifyText += '\n' + msg2;
      }
    }
  } catch (err) {
    const msg = `[${new Date().toISOString()}] Erreur backup : ${err.message}`;
    console.error(msg);
    notifySubject = `bupy: Erreur backup ${DB_TYPE}`;
    notifyText = msg;
    attachmentPath = undefined;
  }
  // Envoi notification email si config présente
  if (SMTP_HOST && SMTP_PORT && SMTP_USER && SMTP_PASS && NOTIFY_EMAIL) {
    try {
      await sendNotification(
        {
          to: NOTIFY_EMAIL,
          subject: notifySubject,
          text: notifyText,
          attachmentPath
        },
        {
          host: SMTP_HOST,
          port: Number(SMTP_PORT),
          secure: Number(SMTP_PORT) === 465, // true pour 465, false sinon
          auth: { user: SMTP_USER, pass: SMTP_PASS }
        }
      );
      console.log(`[${new Date().toISOString()}] Notification email envoyée à ${NOTIFY_EMAIL}`);
    } catch (e) {
      console.error(`[${new Date().toISOString()}] Erreur notification email :`, e.message);
    }
  }
}

if (require.main === module) {
  if (cronSchedule) {
    // Planification automatique
    console.log(`Planification activée : ${cronSchedule}`);
    cron.schedule(cronSchedule, runBackup, { timezone: 'UTC' });
    console.log('bupy est en attente des prochaines exécutions... (Ctrl+C pour quitter)');
  } else {
    // Backup immédiat
    runBackup();
  }
}
