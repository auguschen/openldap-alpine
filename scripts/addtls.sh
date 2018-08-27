#!/usr/bin/env sh

echo "TLSCipherSuite DEFAULT" >> /etc/openldap/slapd.conf
echo "TLSCertificateFile /etc/openldap/ssl/cert.pem" >> /etc/openldap/slapd.conf
echo "TLSCertificateKeyFile /etc/openldap/ssl/key.pem" >> /etc/openldap/slapd.conf
echo "TLSCACertificatePath /usr/share/ca-certificates/mozilla" >> /etc/openldap/slapd.conf
echo "ssl config added."
