// src/backup-mysql.js
// Module responsable du dump MySQL
// Utilise mysqldump via un process enfant

const { exec } = require('child_process');
const path = require('path');
const fs = require('fs');

/**
 * Effectue un dump de la base MySQL
 * @param {Object} options - Options de connexion et de dump
 * @param {string} options.host
 * @param {string} options.port
 * @param {string} options.user
 * @param {string} options.password
 * @param {string} options.database
 * @param {string} options.backupDir
 * @returns {Promise<string>} - Chemin du fichier de backup
 */
function backupMySQL({ host, port, user, password, database, backupDir }) {
  return new Promise((resolve, reject) => {
    const date = new Date().toISOString().replace(/[:.]/g, '-');
    const fileName = `bupy-backup-mysql-${database}-${date}.sql`;
    const filePath = path.join(backupDir, fileName);
    const cmd = `mysqldump -h ${host} -P ${port} -u ${user} -p${password} ${database} > "${filePath}"`;
    fs.mkdirSync(backupDir, { recursive: true });
    exec(cmd, (error, stdout, stderr) => {
      if (error) {
        reject(new Error(stderr || error.message));
      } else {
        resolve(filePath);
      }
    });
  });
}

module.exports = { backupMySQL };
