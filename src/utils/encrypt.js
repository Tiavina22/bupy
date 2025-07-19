const fs = require('fs')
const crypto = require('crypto')
const { error } = require('console')
const { rawlist } = require('@inquirer/prompts'); 


function encryptFile(filePath, outputPath, password) {
    return new Promise((resolve, reject) => {

        const key = crypto.createHash('sha256').update(password).digest();
        const iv = crypto.randomBytes(16);


        const cipher = crypto.createCipheriv("aes-256-cbc", key, iv)

        const input = fs.createReadStream(filePath)
        const output = fs.createWriteStream(outputPath)

        output.write(iv, () => {
            input.pipe(cipher).pipe(output);
        });


        output.on('finish', () => {
            // NOTE: Remove the file with the unencrypted (plaintext) content after encryption
            fs.unlinkSync(filePath)
            resolve(outputPath)
        })

        output.on('error', () => {
            reject(error)
        })
    })
}


async function selectEncryptFile(backupDir) {
    const files = fs.readdirSync(backupDir).filter(f => f.endsWith('.bupy'));
    if (files.length === 0) {
        console.log("No backup files were found in the backup directory.");
        return null;
    }
    const answer = await rawlist({
        message: 'Select the file to decrypt:',
        choices: files,
    });

    return answer
}


module.exports = {
    encryptFile,
    selectEncryptFile
}