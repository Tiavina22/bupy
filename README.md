
# bupy

**bupy** est un outil Node.js open source pour automatiser les sauvegardes (backups) de bases de données PostgreSQL.

## Fonctionnalités principales
- Sauvegarde automatique de PostgreSQL (via `pg_dump`)
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

Créez un fichier `.env` à la racine du projet (voir `.env.example`) :

```env
PGHOST=localhost
PGPORT=5432
PGUSER=postgres
PGPASSWORD=motdepasse
PGDATABASE=ma_base
BACKUP_DIR=./backups
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

## Auteur
Tiavina22
