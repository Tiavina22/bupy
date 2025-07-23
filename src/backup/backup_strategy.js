const { backupPostgres } = require("./backup")
const { backupMySQL } = require("./backup-mysql")
const { backupSQLite } = require("./backup-sqlite")

const strategies = {
    mysql: backupMySQL,
    postgres: backupPostgres,
    sqlite: backupSQLite
}

function getBackupStrategy(dbType) {
    const strategy = strategies[dbType];
    if (!strategy) {
        throw new Error(`Backup strategy for DB type "${dbType}" is not implemented`)
    }
    return strategy;
}


module.exports = { getBackupStrategy }