#!/bin/bash

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "[-] Please run this script with sudo."
  echo "    Usage: sudo $0 <domain> <relay_email> <app_password>"
  exit 1
fi

# Arguments check
DOMAIN=$1
RELAY_EMAIL=$2
RELAY_PASS=$3

if [ -z "$DOMAIN" ] || [ -z "$RELAY_EMAIL" ] || [ -z "$RELAY_PASS" ]; then
  echo "[-] Error: Missing arguments!"
  echo "    Usage: sudo $0 <domain> <relay_email> <app_password>"
  echo "    Example: sudo $0 yourdomain.com myemail@gmail.com myappassword123"
  exit 1
fi

# Automatically detect the real user running sudo (fallback to whoami)
REAL_USER=${SUDO_USER:-$(whoami)}

echo "[+] Starting Postfix and custom domain mail setup for: $DOMAIN"

# Preseed debconf selections to skip interactive installation prompts
echo "postfix postfix/mailname string mail.$DOMAIN" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections

# 1. Install packages
echo "[*] Installing Postfix, mailutils, and dependencies..."
apt-get update
apt-get install -y postfix mailutils libsasl2-modules

# 2. Configure SASL Password Map for Gmail/Relay
echo "[*] Configuring SASL authentication credentials..."
mkdir -p /etc/postfix/sasl
echo "[smtp.gmail.com]:587 $RELAY_EMAIL:$RELAY_PASS" > /etc/postfix/sasl/sasl_passwd
chmod 600 /etc/postfix/sasl/sasl_passwd
postmap /etc/postfix/sasl/sasl_passwd

# 3. Write Complete main.cf Configuration
echo "[*] Writing /etc/postfix/main.cf..."
cat <<EOF > /etc/postfix/main.cf
smtpd_banner = \$myhostname ESMTP \$mail_name (Ubuntu)
biff = no
append_dot_mydomain = no
readme_directory = no
compatibility_level = 3.6

smtpd_tls_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
smtpd_tls_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
smtpd_use_tls=yes
smtpd_tls_session_cache_database = btree:\${data_directory}/smtpd_scache
smtp_tls_session_cache_database = btree:\${data_directory}/smtp_scache

smtpd_tls_security_level=may
smtp_tls_security_level=encrypt
smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt

myhostname = mail.$DOMAIN
mydomain = $DOMAIN
myorigin = \$mydomain
mydestination = \$myhostname, localhost.\$mydomain, localhost

relayhost = [smtp.gmail.com]:587
smtp_sasl_auth_enable = yes
smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd
smtp_sasl_security_options = noanonymous

local_header_rewrite_clients = restrict_envelope_sender:\$mydomain
smtp_generic_maps = hash:/etc/postfix/generic

mynetworks = 127.0.0.0/8 [::1]/128
mailbox_size_limit = 0
recipient_delimiter = +
inet_interfaces = loopback-only
inet_protocols = all
EOF

# 4. Write Generic Address Mapping for current system user
echo "[*] Writing generic address map for user ($REAL_USER)..."
cat <<EOF > /etc/postfix/generic
root@localhost noreply@$DOMAIN
root noreply@$DOMAIN
$REAL_USER@localhost noreply@$DOMAIN
$REAL_USER noreply@$DOMAIN
EOF
postmap /etc/postfix/generic

# 5. Restart Postfix Service
echo "[*] Restarting Postfix service..."
systemctl restart postfix
systemctl enable postfix

echo "[+] Mail server setup successfully completed!"
echo "------------------------------------------------------------------"
echo "To test your installation, run:"
echo "echo \"Test body content\" | mail -s \"Test Subject\" -r \"noreply@$DOMAIN\" your-target-email@gmail.com"
echo "------------------------------------------------------------------"
