// src/test-backup.js
// Test simple pour vérifier le fonctionnement du module de backup PostgreSQL

require('dotenv').config();
const { backupPostgres } = require('./backup');

const {
  PGHOST: host,
  PGPORT: port,
  PGUSER: user,
  PGPASSWORD: password,
  PGDATABASE: database,
  BACKUP_DIR: backupDir
} = process.env;

if (!host || !port || !user || !password || !database || !backupDir) {
  console.error('Configuration manquante. Veuillez vérifier votre fichier .env.');
  process.exit(1);
}

backupPostgres({ host, port, user, password, database, backupDir })
  .then(filePath => {
    console.log(`Test OK : backup créé à ${filePath}`);
    process.exit(0);
  })
  .catch(err => {
    console.error('Test ÉCHEC :', err.message);
    process.exit(2);
  });
