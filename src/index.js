
// Chargement de la configuration depuis .env
require('dotenv').config();


const { backupPostgres } = require('./backup');
const { cleanupBackups } = require('./retention');


const cron = require('node-cron');


const {
  PGHOST: host,
  PGPORT: port,
  PGUSER: user,
  PGPASSWORD: password,
  PGDATABASE: database,
  BACKUP_DIR: backupDir,
  CRON_SCHEDULE: cronSchedule,
  RETENTION_DAYS: retentionDays
} = process.env;

if (!host || !port || !user || !password || !database || !backupDir) {
  console.error('Configuration manquante. Veuillez vérifier votre fichier .env.');
  process.exit(1);
}


async function runBackup() {
  try {
    const filePath = await backupPostgres({ host, port, user, password, database, backupDir });
    console.log(`[${new Date().toISOString()}] Backup PostgreSQL réussi : ${filePath}`);
    if (retentionDays && !isNaN(Number(retentionDays))) {
      const deleted = await cleanupBackups(backupDir, Number(retentionDays));
      if (deleted > 0) {
        console.log(`[${new Date().toISOString()}] Rétention : ${deleted} ancien(s) backup(s) supprimé(s).`);
      }
    }
  } catch (err) {
    console.error(`[${new Date().toISOString()}] Erreur lors du backup PostgreSQL :`, err.message);
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
