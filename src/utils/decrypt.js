const fs = require('fs');
const crypto = require('crypto');

function decryptFile(encryptedPath, outputPath, password) {
    return new Promise((resolve, reject) => {
        try {
            const key = crypto.createHash('sha256').update(password).digest();

            const input = fs.createReadStream(encryptedPath, { start: 16 });
            const ivBuffer = Buffer.alloc(16);
            const fd = fs.openSync(encryptedPath, 'r');
            fs.readSync(fd, ivBuffer, 0, 16, 0);
            fs.closeSync(fd);

            const decipher = crypto.createDecipheriv('aes-256-cbc', key, ivBuffer);
            const output = fs.createWriteStream(outputPath);

            input.on('error', (err) => reject(err));
            decipher.on('error', (err) => {
                if (err.message.includes("bad decrypt")) {
                    reject(new Error("Incorrect password or corrupted file."))
                }
                else {
                    reject(new Error(`Decryption failed: ${err.message}`))
                }

            })
            output.on('error', (err) => reject(err));
            input.pipe(decipher).pipe(output);
            output.on('finish', () => resolve(outputPath));
        }
        catch (error) {
            reject(error)
        }

    });
}


module.exports = {
    decryptFile
}
