---
sidebar_position: 2
---

# Configuration

Créez un fichier `.env` à la racine du projet avec le contenu suivant :

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

- `CRON_SCHEDULE` : planification (ex : `0 2 * * *` pour tous les jours à 2h)
- `RETENTION_DAYS` : nombre de jours de conservation des backups
- Les notifications email sont optionnelles.
