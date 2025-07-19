// src/backup-sqlite.js
// Module responsable du backup SQLite (copie du fichier .db)

const path = require('path');
const fs = require('fs');
const { encryptFile } = require('../utils/encrypt');

/**
 * Effectue un backup du fichier SQLite
 * @param {Object} options
 * @param {string} options.sqlitePath - Chemin du fichier .db
 * @param {string} options.backupDir - Dossier de backup
 * @returns {Promise<string>} - Chemin du fichier de backup
 */
function backupSQLite({ sqlitePath, backupDir }) {
  return new Promise((resolve, reject) => {
    if (!fs.existsSync(sqlitePath)) {
      return reject(new Error('Fichier SQLite introuvable'));
    }
    const date = new Date().toISOString().replace(/[:.]/g, '-');
    const fileName = `bupy-backup-sqlite-${date}.db`;
    let filePath = path.join(backupDir, fileName);
    fs.mkdirSync(backupDir, { recursive: true });
    fs.copyFile(sqlitePath, filePath, async (err) => {
      if (err) return reject(err);
      // NOTE: Value 1 indicates that the user wants to encrypt the output file
      if (encryption_enabled == 1) {
        const outputPath = path.join(backupDir, `${fileName}.bupy`)
        filePath = await encryptFile(filePath, outputPath, encryption_password)
      }
      resolve(filePath);
    });
  });
}

module.exports = { backupSQLite };
