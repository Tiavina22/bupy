---
sidebar_position: 4
---

# Notifications

bupy peut envoyer un email après chaque backup (succès ou échec).

- Configurez la section SMTP dans `.env`.
- L’email contient le fichier de backup en pièce jointe en cas de succès.

## Exemple de configuration

```env
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=utilisateur@gmail.com
SMTP_PASS=motdepasse
NOTIFY_EMAIL=destinataire@gmail.com
```

## Tester l’envoi d’email

```bash
node src/test-notify.js
```
