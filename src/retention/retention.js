// src/retention.js
// Module de gestion de la rétention des backups PostgreSQL
// Supprime les fichiers de backup plus anciens qu'une durée configurée

const fs = require('fs');
const path = require('path');

/**
 * Supprime les fichiers de backup plus anciens que maxAge (en jours)
 * @param {string} backupDir - Dossier des backups
 * @param {number} maxAgeDays - Nombre de jours de rétention
 * @returns {Promise<number>} - Nombre de fichiers supprimés
 */
async function cleanupBackups(backupDir, maxAgeDays) {
  const now = Date.now();
  const maxAgeMs = maxAgeDays * 24 * 60 * 60 * 1000;
  let deleted = 0;
  if (!fs.existsSync(backupDir)) return 0;
  const files = fs.readdirSync(backupDir);
  for (const file of files) {
    if (!file.startsWith('bupy-backup-') || !file.endsWith('.sql')) continue;
    const filePath = path.join(backupDir, file);
    const stats = fs.statSync(filePath);
    if (now - stats.mtimeMs > maxAgeMs) {
      fs.unlinkSync(filePath);
      deleted++;
    }
  }
  return deleted;
}

module.exports = { cleanupBackups };
