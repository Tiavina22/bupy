// src/test-retention.js
// Test dédié pour la gestion de la rétention des backups

require('dotenv').config();
const { cleanupBackups } = require('./retention');

const backupDir = process.env.BACKUP_DIR;
const retentionDays = Number(process.env.RETENTION_DAYS);

if (!backupDir || isNaN(retentionDays)) {
  console.error('Configuration manquante : BACKUP_DIR ou RETENTION_DAYS.');
  process.exit(1);
}

cleanupBackups(backupDir, retentionDays)
  .then(deleted => {
    console.log(`Test rétention OK : ${deleted} backup(s) supprimé(s).`);
    process.exit(0);
  })
  .catch(err => {
    console.error('Test rétention ÉCHEC :', err.message);
    process.exit(2);
  });
