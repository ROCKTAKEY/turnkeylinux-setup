#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: $0 <domain>"
	exit 1
fi

DOMAIN=$1

# Modify /etc/postfix/main.cf
sudo sed -i 's/smtp_tls_security_level = may/smtp_tls_security_level = encrypt/' /etc/postfix/main.cf
echo "smtp_tls_wrappermode = yes" | sudo tee -a /etc/postfix/main.cf
echo "mydomain = $DOMAIN" | sudo tee -a /etc/postfix/main.cf

# Run chfn
sudo chfn -f "$(hostname)" root
