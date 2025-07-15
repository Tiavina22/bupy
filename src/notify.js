// src/notify.js
// Module d'envoi de notifications par email avec nodemailer

const nodemailer = require('nodemailer');

/**
 * Envoie un email de notification
 * @param {Object} options
 * @param {string} options.to - Destinataire
 * @param {string} options.subject - Sujet
 * @param {string} options.text - Corps du message
 * @param {string} options.html - Corps HTML (optionnel)
 * @param {Object} smtpConfig - Config nodemailer (host, port, user, pass, etc.)
 * @returns {Promise<void>}
 */
async function sendNotification({ to, subject, text, html }, smtpConfig) {
  const transporter = nodemailer.createTransport(smtpConfig);
  await transporter.sendMail({
    from: smtpConfig.auth.user,
    to,
    subject,
    text,
    html
  });
}

module.exports = { sendNotification };
