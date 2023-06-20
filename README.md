# Homelab: Home Assistant - Configuration

[![](https://img.shields.io/github/license/muhlba91/homelab-home-assistant-configuration?style=for-the-badge)](LICENSE)
[![](https://img.shields.io/github/actions/workflow/status/muhlba91/homelab-home-assistant-configuration/verify.yml?style=for-the-badge)](https://github.com/muhlba91/homelab-home-assistant-configuration/actions/workflows/verify.yml)
<a href="https://www.buymeacoffee.com/muhlba91" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="28" width="150"></a>

This repository contains [Home Assistant](http://home-assistant.io) configuration, and lifecycle scripts.

---

## Configuration

The main configuration is located in [`configuration/configuration.yaml`](configuration/configuration.yaml) with secrets being stored in [`configuration/secrets.yaml`](configuration/secrets.yaml).

### Secrets Encryption

All secrets are encrypted with [sops](https://github.com/mozilla/sops) and [Google Cloud KMS](https://cloud.google.com/security-key-management).

## Lifecycle Scripts

The directory [`lifecycle`](lifecycle/) contains all lifecycle scripts:

- `prepare.sh`: installs all custom and www components defined in [`configuration/custom_components.txt`](configuration/custom_components.txt) and [`configuration/www_components.txt`](configuration/www_components.txt)
- `sops.sh`: encrypts or decrypts all necessary files (pass `e` for encryption, and `d` for decryption)
- `backup_restore.sh`: checks if data exists and either backups or restores the configuration

---

## Supporting

If you enjoy the application and want to support my efforts, please feel free to buy me a coffe. :)

<a href="https://www.buymeacoffee.com/muhlba91" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/default-orange.png" alt="Buy Me A Coffee" height="75" width="300"></a>
