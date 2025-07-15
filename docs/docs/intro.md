---
sidebar_position: 1
---



# bupy

![GitHub stars](https://img.shields.io/github/stars/Tiavina22/bupy?style=social)
![GitHub license](https://img.shields.io/github/license/Tiavina22/bupy)
![GitHub last commit](https://img.shields.io/github/last-commit/Tiavina22/bupy)

**bupy** est un outil Node.js open source pour automatiser les sauvegardes (backups) de bases de données PostgreSQL.

> Sauvegardes automatiques, rétention intelligente, notifications email, configuration simple.

---

## 🚀 Fonctionnalités principales

- Sauvegarde automatique de PostgreSQL (via `pg_dump`)
- Stockage local configurable
- Planification flexible (cron)
- Rétention automatique des anciens backups
- Notifications email (avec pièce jointe du backup)
- Interface CLI simple et scripts de test

---

## 📦 Installation rapide

```bash
git clone https://github.com/Tiavina22/bupy.git
cd bupy
npm install
```

---

## ⚡️ Prise en main rapide

1. Copiez `.env.example` en `.env` et adaptez la configuration.
2. Lancez un backup immédiat :
   ```bash
   node src/index.js
   ```
3. Consultez la [documentation complète](https://tiavina22.github.io/bupy/)

---

## 📚 Table des matières

- [Configuration](./configuration.md)
- [Utilisation CLI](./cli.md)
- [Notifications](./notifications.md)
- [FAQ](./faq.md)

---

## ✨ Projet open source par [Tiavina22](https://github.com/Tiavina22)

The `cd` command changes the directory you're working with. In order to work with your newly created Docusaurus site, you'll need to navigate the terminal there.

The `npm run start` command builds your website locally and serves it through a development server, ready for you to view at http://localhost:3000/.

Open `docs/intro.md` (this page) and edit some lines: the site **reloads automatically** and displays your changes.
