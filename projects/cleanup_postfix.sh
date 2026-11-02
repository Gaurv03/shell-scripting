#!/bin/bash

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "[-] Please run this script with sudo or as root."
  exit 1
fi

echo "[+] Starting complete cleanup of Postfix, mail utilities, and custom configurations..."

# 1. Stop Postfix service
echo "[*] Stopping Postfix..."
systemctl stop postfix 2>/dev/null

# 2. Purge packages and remove all configuration files
echo "[*] Purging postfix, mailutils, and libsasl2-modules..."
apt-get purge -y postfix mailutils libsasl2-modules

# 3. Remove orphaned dependencies left behind
echo "[*] Removing unused dependencies (autoremove)..."
apt-get autoremove -y --purge

# 4. Clean up leftover Postfix configuration directories, SASL files, and generic maps
echo "[*] Cleaning up leftover configuration directories and data files..."
rm -rf /etc/postfix
rm -rf /var/spool/postfix
rm -rf /var/lib/postfix

echo "[+] Cleanup completed successfully! Your local machine has been completely reverted."
