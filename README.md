

# bupy

**bupy** is an open-source Node.js tool to automate backups for PostgreSQL, MySQL, and SQLite databases.

## Main Features
- Automatic backup for PostgreSQL (via `pg_dump`), MySQL (via `mysqldump`), or SQLite (file copy)
- Configurable local storage
- Flexible scheduling (cron)
- Automatic retention of old backups
- Email notifications (with backup attachment)
- Backup encryption (encrypt) and decryption (decrypt) support
- Simple CLI interface and test scripts

## Installation

```bash
git clone https://github.com/Tiavina22/bupy.git
cd bupy
npm install
```

## Quick Configuration

Create a `.env` file at the root of the project (see `.env.example`) and choose the database type to backup:

### For PostgreSQL
```env
DB_TYPE=postgres
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=yourpassword
PGDATABASE=your_db
BACKUP_DIR=./backups
```

### For MySQL
```env
DB_TYPE=mysql
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=yourpassword
MYSQL_DATABASE=your_db
BACKUP_DIR=./backups
```

### For SQLite
```env
DB_TYPE=sqlite
SQLITE_PATH=./your_db.db
BACKUP_DIR=./backups
```

### Common Options
```
CRON_SCHEDULE=0 2 * * *
RETENTION_DAYS=7
# Email notifications (optional)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your_email@gmail.com
SMTP_PASS=yourpassword
NOTIFY_EMAIL=recipient@gmail.com

# Backup encryption (optional)
ENCRYPTION_ENABLED=0   # 1 to enable encryption, 0 to disable
ENCRYPTION_PASSWORD=   # Can be left empty, password will be prompted during encrypted backup
```

## Usage

### Simplified npm commands

- Immediate backup:
  ```bash
  npm run backup
  ```
- Encrypted backup (will prompt for password):
  ```bash
  npm run backup:encrypt
  ```
- Decrypt a backup (will prompt for file and password):
  ```bash
  npm run decrypt -- --f path/to/backup.sql.bupy
  ```

### Other commands

- Test retention:
  ```bash
  node src/test-retention.js
  ```
- Test email notification:
  ```bash
  node src/test-notify.js
  ```

## Full Documentation

Official documentation and resources:
- [https://bupy-site.vercel.app/](https://bupy-site.vercel.app/)
- Docusaurus documentation: [https://tiavina22.github.io/bupy/](https://tiavina22.github.io/bupy/)

## Project Structure
- `src/`: main logic (backup, retention, notification)
- `docs/`: Docusaurus documentation
- `.env.example`: configuration example
