
// Chargement de la configuration depuis .env
require('dotenv').config({ path: require('path').resolve(__dirname, '../.env') });

const { cleanupBackups } = require('./retention/retention');
const { sendNotification } = require('./notify/notify');

const cron = require('node-cron');
const { validateConfig } = require('./config/config');
const { getBackupStrategy } = require('./backup/backup_strategy');
const path = require('path');
const { selectEncryptFile } = require("./utils/encrypt")
const args = require('minimist')(process.argv.slice(2))
var prompt = require('prompt-sync')()
const fs = require('fs');
const { decryptFile } = require('./utils/decrypt');
// NOTE: Default to the "backups" folder at the project root if no directory is provided via args or env.
const backupDir = path.resolve(
  args.BACKUP_DIR || process.env.BACKUP_DIR || '../backups'
)

const {
  DB_TYPE = 'postgres',
  PGHOST, PGPORT, PGUSER, PGPASSWORD, PGDATABASE,
  MYSQL_HOST, MYSQL_PORT, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE,
  SQLITE_PATH,
  CRON_SCHEDULE: cronSchedule,
  RETENTION_DAYS: retentionDays,
  SMTP_HOST,
  SMTP_PORT,
  SMTP_USER,
  SMTP_PASS,
  NOTIFY_EMAIL
} = process.env;

async function decryptBackup() {
  try {
    let decryption_password = ""
    let targetEncryptedFile = ""
    if (args.f) {
      // NOTE: Check whether the provided file path exists
      if (!fs.existsSync(args.f)) {
        throw new Error(`The file "${args.f}" does not exist. Please provide a valid path.`)
      }
      targetEncryptedFile = args.f
    }
    else {
      const chosenBackupFile = await selectEncryptFile(backupDir)
      targetEncryptedFile = path.join(backupDir, chosenBackupFile);
    }

    // NOTE: If the file to decrypt exists, prompt the user to enter the decryption password
    do {
      decryption_password = prompt.hide('Enter your decryption password: ');
      if (!decryption_password) {
        console.log("Password cannot be empty. Please try again.");
      }
    } while (!decryption_password);

    const decryptedOutputPath = targetEncryptedFile.slice(0, -'.bupy'.length);

    const decryptedFilePath = await decryptFile(targetEncryptedFile, decryptedOutputPath, decryption_password);

    console.log("Decryption completed successfully. Output file:", decryptedFilePath);


  } catch (error) {
    const msg = `[${new Date().toISOString()}] Erreur decryption : ${error.message}`;
    console.error(msg);
  }
}


async function runBackup() {
  let notifySubject, notifyText, attachmentPath = undefined;
  try {

    let encryption_password = ''

    // NOTE: If the "encrypt" argument is provided, prompt the user to enter a password

    if (args.encrypt) {
      do {
        encryption_password = prompt.hide('Enter your encryption password: ');
        if (!encryption_password) {
          console.log("Password cannot be empty. Please try again.");
        }
      } while (!encryption_password);
    }

    let filePath, msg;

    // NOTE: Verify that all required configurations are present and valid, including the existence of the backup directory
    filePath = validateConfig(DB_TYPE)

    //NOTE: Get the strategie based on the type of the DB
    const backupFunction = getBackupStrategy(DB_TYPE)

    let options = { filePath }

    switch (DB_TYPE) {
      case 'postgres': {
        options = {
          ...options,
          host: PGHOST,
          port: PGPORT,
          user: PGUSER,
          password: PGPASSWORD,
          database: PGDATABASE,
          backupDir,
          encryption_enabled: (args.encrypt) ? 1 : 0,
          encryption_password
        }
        break
      }
      case 'mysql': {
        options = {
          ...options,
          host: MYSQL_HOST,
          port: MYSQL_PORT,
          user: MYSQL_USER,
          password: MYSQL_PASSWORD,
          database: MYSQL_DATABASE,
          backupDir
        }
        break
      }
      case 'sqlite': {
        options = {
          ...options,
          sqlitePath: SQLITE_PATH,
          backupDir
        }
        break
      }

      default: {
        throw new Error("DB_TYPE not supported")
      }
    }
    filePath = await backupFunction(options)
    msg = `[${new Date().toISOString()}] Backup ${DB_TYPE} réussi : ${filePath}`;

    console.log(msg);
    notifySubject = `bupy: Backup ${DB_TYPE} réussi`;
    notifyText = msg;
    attachmentPath = filePath;


    if (retentionDays && !isNaN(Number(retentionDays))) {
      const deleted = await cleanupBackups(backupDir, Number(retentionDays));
      if (deleted > 0) {
        const msg2 = `[${new Date().toISOString()}] Rétention : ${deleted} ancien(s) backup(s) supprimé(s).`;
        console.log(msg2);
        notifyText += '\n' + msg2;
      }
    }
  } catch (err) {
    const msg = `[${new Date().toISOString()}] Erreur backup : ${err.message}`;
    console.error(msg);
    notifySubject = `bupy: Erreur backup ${DB_TYPE}`;
    notifyText = msg;
    attachmentPath = undefined;
  }
  // Envoi notification email si config présente
  if (SMTP_HOST && SMTP_PORT && SMTP_USER && SMTP_PASS && NOTIFY_EMAIL) {
    try {
      await sendNotification(
        {
          to: NOTIFY_EMAIL,
          subject: notifySubject,
          text: notifyText,
          attachmentPath
        },
        {
          host: SMTP_HOST,
          port: Number(SMTP_PORT),
          secure: Number(SMTP_PORT) === 465, // true pour 465, false sinon
          auth: { user: SMTP_USER, pass: SMTP_PASS }
        }
      );
      console.log(`[${new Date().toISOString()}] Notification email envoyée à ${NOTIFY_EMAIL}`);
    } catch (e) {
      console.error(`[${new Date().toISOString()}] Erreur notification email :`, e.message);
    }
  }
}


if (require.main === module) {

  (async () => {
    if (cronSchedule) {
      // Planification automatique
      console.log(`Planification activée : ${cronSchedule}`);
      cron.schedule(cronSchedule, runBackup, { timezone: 'UTC' });
      console.log('bupy est en attente des prochaines exécutions... (Ctrl+C pour quitter)');
    } else {
      // NOTE: If "decrypt" is not present in the arguments, the operation defaults to backup, not decryption
      if (!args.decrypt) {
        // Backup immédiat
        runBackup();
      }
      else {
        decryptBackup()
      }

    }
  })();

}
