function validateConfig(dbType) {
    const common_required = ['BACKUP_DIR', 'ENCRYPTION_ENABLED', 'ENCRYPTION_PASSWORD']
    const requiredByDB = {
        postgres: ['PGHOST', 'PGPORT', 'PGUSER', 'PGPASSWORD', 'PGDATABASE'],
        mysql: ['MYSQL_HOST', 'MYSQL_PORT', 'MYSQL_USER', 'MYSQL_PASSWORD', 'MYSQL_DATABASE'],
        sqlite: ['SQLITE_PATH']
    }
    //NOTE: Verify if all variables are declared
    const required = [...(requiredByDB[dbType] || []), ...common_required];
    for (const key of required) {
        if (!process.env[key]) {
            throw new Error(`Environment variable "${key}" is missing but required for database type "${dbType}".`);
        }
    }

    // NOTE: Check if the backup folder exists; create it if it doesn't
    const backupDir = path.resolve(process.env.BACKUP_DIR);
    if (!fs.existsSync(backupDir)) {
        fs.mkdirSync(backupDir, { recursive: true });
    }

    return backupDir;

}

