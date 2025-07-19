// src/test-notify.js
// Test dédié pour l'envoi de notifications email

require('dotenv').config();
const { sendNotification } = require('./notify');

const {
  SMTP_HOST,
  SMTP_PORT,
  SMTP_USER,
  SMTP_PASS,
  NOTIFY_EMAIL
} = process.env;

if (!SMTP_HOST || !SMTP_PORT || !SMTP_USER || !SMTP_PASS || !NOTIFY_EMAIL) {
  console.error('Configuration SMTP ou NOTIFY_EMAIL manquante.');
  process.exit(1);
}

sendNotification(
  {
    to: NOTIFY_EMAIL,
    subject: 'bupy: Test de notification email',
    text: 'Ceci est un test de notification email depuis bupy.'
  },
  {
    host: SMTP_HOST,
    port: Number(SMTP_PORT),
    secure: Number(SMTP_PORT) === 465,
    auth: { user: SMTP_USER, pass: SMTP_PASS }
  }
)
  .then(() => {
    console.log('Test notification OK : email envoyé.');
    process.exit(0);
  })
  .catch(err => {
    console.error('Test notification ÉCHEC :', err.message);
    process.exit(2);
  });
