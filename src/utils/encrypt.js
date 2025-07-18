const fs = require('fs')
const crypto = require('crypto')
const { error } = require('console')

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
            resolve()
        })

        output.on('error', () => {
            reject(error)
        })
    })
}



module.exports = {
    encryptFile
}