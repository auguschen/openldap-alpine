#!/usr/bin/env sh

if [[ -n "$SUFFIX" ]]; then
  sed -i "s/suffix\t\t\"dc=my-domain,dc=com\"/suffix\t\t\"$SUFFIX\"/" /etc/openldap/slapd.conf
fi 

if [[ -n "$ROOTDN" ]]; then
  ROOTDNFULL=$ROOTDN","$SUFFIX
  sed -i "s/rootdn\t\t\"cn=Manager,dc=my-domain,dc=com\"/rootdn\t\t\"$ROOTDNFULL\"/" /etc/openldap/slapd.conf
fi 

if [[ -n "$ROOTPW" ]]; then
  sed -i "/rootpw/ d" /etc/openldap/slapd.conf
  echo "rootpw          $(slappasswd -s ${ROOTPW})" >> /etc/openldap/slapd.conf
fi 

echo "include         /etc/openldap/schema/cosine.schema" >> /etc/openldap/slapd.conf
echo "include         /etc/openldap/schema/inetorgperson.schema" >> /etc/openldap/slapd.conf
echo "include         /etc/openldap/schema/nis.schema" >> /etc/openldap/slapd.conf

cp /var/lib/openldap/openldap-data/DB_CONFIG.example /var/lib/openldap/openldap-data/DB_CONFIG

if [ ! -d "/run/openldap" ]; then mkdir -p /run/openldap; fi

if [ ! -d "/etc/openldap/ssl" ]; then mkdir -p /etc/openldap/ssl; fi

if [ ! -d "/etc/openldap/slapd.d" ]; then mkdir -p /etc/openldap/slapd.d; fi

chown -R ldap:ldap /etc/openldap/slapd.d

rm -rf /etc/openldap/slapd.d/*

slaptest -u -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d/