
# bupy


**bupy** est un outil Node.js open source pour automatiser les sauvegardes (backups) de bases de données PostgreSQL, MySQL et SQLite.


## Fonctionnalités principales
- Sauvegarde automatique de PostgreSQL (via `pg_dump`), MySQL (via `mysqldump`) ou SQLite (copie du fichier)
- Stockage local configurable
- Planification flexible (cron)
- Rétention automatique des anciens backups
- Notifications email (avec pièce jointe du backup)
- Interface CLI simple et scripts de test

## Installation

```bash
git clone https://github.com/Tiavina22/bupy.git
cd bupy
npm install
```


## Configuration rapide

Créez un fichier `.env` à la racine du projet (voir `.env.example`) et choisissez le type de base à sauvegarder :

### Pour PostgreSQL
```env
DB_TYPE=postgres
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=motdepasse
PGDATABASE=ma_base
BACKUP_DIR=./backups
```

### Pour MySQL
```env
DB_TYPE=mysql
MYSQL_HOST=localhost
MYSQL_PORT=3306
MYSQL_USER=root
MYSQL_PASSWORD=motdepasse
MYSQL_DATABASE=ma_base
BACKUP_DIR=./backups
```

### Pour SQLite
```env
DB_TYPE=sqlite
SQLITE_PATH=./ma_base.db
BACKUP_DIR=./backups
```

### Options communes
```
CRON_SCHEDULE=0 2 * * *
RETENTION_DAYS=7
# Notifications email (optionnel)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=utilisateur@gmail.com
SMTP_PASS=motdepasse
NOTIFY_EMAIL=destinataire@gmail.com
```

## Utilisation

- Lancer un backup immédiat :
  ```bash
  node src/index.js
  ```
- Lancer le mode planifié (selon CRON_SCHEDULE) :
  ```bash
  node src/index.js
  ```
- Tester la rétention :
  ```bash
  node src/test-retention.js
  ```
- Tester la notification email :
  ```bash
  node src/test-notify.js
  ```

## Documentation complète

La documentation détaillée est disponible sur [https://tiavina22.github.io/bupy/](https://tiavina22.github.io/bupy/)

## Structure du projet
- `src/` : logique principale (backup, rétention, notification)
- `docs/` : documentation Docusaurus
- `.env.example` : exemple de configuration
