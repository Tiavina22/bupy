// src/backup.js
// Module responsable du dump PostgreSQL
// Utilise pg_dump via un process enfant

const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');
const { encryptFile } = require('../utils/encrypt');

/**
 * Effectue un dump de la base PostgreSQL
 * @param {Object} options - Options de connexion et de dump
 * @param {string} options.host
 * @param {string} options.port
 * @param {string} options.user
 * @param {string} options.password
 * @param {string} options.database
 * @param {string} options.backupDir
 * @param {number} options.encryption_enabled
 * @param {string} options.encryption_password
 * @returns {Promise<string>} - Chemin du fichier de backup
 */
function backupPostgres({ host, port, user, password, database, backupDir, encryption_enabled, encryption_password }) {
  return new Promise((resolve, reject) => {
    const date = new Date().toISOString().replace(/[:.]/g, '-');
    const fileName = `bupy-backup-${database}-${date}.sql`;
    const filePath = path.join(backupDir, fileName);
    const env = { ...process.env, PGPASSWORD: password };
    const cmd = `pg_dump -h ${host} -p ${port} -U ${user} -F p -d ${database} -f "${filePath}"`;
    fs.mkdirSync(backupDir, { recursive: true });
    exec(cmd, { env }, async (error, stdout, stderr) => {
      if (error) {
        reject(new Error(stderr || error.message));
      } else {
        console.log("File path ", filePath)
        console.log("Encrypted enabled ", encryption_enabled)
        if (encryption_enabled == 1) {
          const outputPath = path.join(backupDir, `${fileName}.bupy`)
          console.log("Output path: ", outputPath)
          await encryptFile(filePath, outputPath, encryption_password)
        }

        resolve(filePath);
      }
    });
  });
}

module.exports = { backupPostgres };
