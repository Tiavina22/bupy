
// Chargement de la configuration depuis .env
require('dotenv').config();



const { backupPostgres } = require('./backup');
const { cleanupBackups } = require('./retention');
const { sendNotification } = require('./notify');


const cron = require('node-cron');



const {
  PGHOST: host,
  PGPORT: port,
  PGUSER: user,
  PGPASSWORD: password,
  PGDATABASE: database,
  BACKUP_DIR: backupDir,
  CRON_SCHEDULE: cronSchedule,
  RETENTION_DAYS: retentionDays,
  SMTP_HOST,
  SMTP_PORT,
  SMTP_USER,
  SMTP_PASS,
  NOTIFY_EMAIL
} = process.env;

if (!host || !port || !user || !password || !database || !backupDir) {
  console.error('Configuration manquante. Veuillez vérifier votre fichier .env.');
  process.exit(1);
}



async function runBackup() {
  let notifySubject, notifyText;
  try {
    const filePath = await backupPostgres({ host, port, user, password, database, backupDir });
    const msg = `[${new Date().toISOString()}] Backup PostgreSQL réussi : ${filePath}`;
    console.log(msg);
    notifySubject = 'bupy: Backup PostgreSQL réussi';
    notifyText = msg;
    if (retentionDays && !isNaN(Number(retentionDays))) {
      const deleted = await cleanupBackups(backupDir, Number(retentionDays));
      if (deleted > 0) {
        const msg2 = `[${new Date().toISOString()}] Rétention : ${deleted} ancien(s) backup(s) supprimé(s).`;
        console.log(msg2);
        notifyText += '\n' + msg2;
      }
    }
  } catch (err) {
    const msg = `[${new Date().toISOString()}] Erreur lors du backup PostgreSQL : ${err.message}`;
    console.error(msg);
    notifySubject = 'bupy: Erreur backup PostgreSQL';
    notifyText = msg;
  }
  // Envoi notification email si config présente
  if (SMTP_HOST && SMTP_PORT && SMTP_USER && SMTP_PASS && NOTIFY_EMAIL) {
    try {
      await sendNotification(
        {
          to: NOTIFY_EMAIL,
          subject: notifySubject,
          text: notifyText
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
