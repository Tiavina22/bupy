// src/backup.js
// Module responsable du dump PostgreSQL
// Utilise pg_dump via un process enfant

const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');

/**
 * Effectue un dump de la base PostgreSQL
 * @param {Object} options - Options de connexion et de dump
 * @param {string} options.host
 * @param {string} options.port
 * @param {string} options.user
 * @param {string} options.password
 * @param {string} options.database
 * @param {string} options.backupDir
 * @returns {Promise<string>} - Chemin du fichier de backup
 */
function backupPostgres({ host, port, user, password, database, backupDir }) {
  return new Promise((resolve, reject) => {
    const date = new Date().toISOString().replace(/[:.]/g, '-');
    const fileName = `bupy-backup-${database}-${date}.sql`;
    const filePath = path.join(backupDir, fileName);
    const env = { ...process.env, PGPASSWORD: password };
    const cmd = `pg_dump -h ${host} -p ${port} -U ${user} -F p -d ${database} -f "${filePath}"`;
    fs.mkdirSync(backupDir, { recursive: true });
    exec(cmd, { env }, (error, stdout, stderr) => {
      if (error) {
        reject(new Error(stderr || error.message));
      } else {
        resolve(filePath);
      }
    });
  });
}

module.exports = { backupPostgres };
