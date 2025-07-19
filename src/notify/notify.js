// src/notify.js
// Module d'envoi de notifications par email avec nodemailer

const nodemailer = require('nodemailer');


/**
 * Envoie un email de notification
 * @param {Object} options
 * @param {string} options.to - Destinataire
 * @param {string} options.subject - Sujet
 * @param {string} options.text - Corps du message
 * @param {string} [options.html] - Corps HTML (optionnel)
 * @param {string} [options.attachmentPath] - Chemin du fichier à joindre (optionnel)
 * @param {Object} smtpConfig - Config nodemailer (host, port, user, pass, etc.)
 * @returns {Promise<void>}
 */
async function sendNotification({ to, subject, text, html, attachmentPath }, smtpConfig) {
  const transporter = nodemailer.createTransport(smtpConfig);
  const mailOptions = {
    from: smtpConfig.auth.user,
    to,
    subject,
    text,
    html
  };
  if (attachmentPath) {
    mailOptions.attachments = [
      {
        filename: require('path').basename(attachmentPath),
        path: attachmentPath
      }
    ];
  }
  await transporter.sendMail(mailOptions);
}

module.exports = { sendNotification };
