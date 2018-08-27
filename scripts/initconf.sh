#!/usr/bin/env sh

echo "init config..."
if [[ -n "$SUFFIX_PATH" ]]; then
  SUFFIX_CONTENT=`cat ${SUFFIX_PATH}`
  sed -i "s/suffix\t\t\"dc=my-domain,dc=com\"/suffix\t\t\"$SUFFIX_CONTENT\"/" /etc/openldap/slapd.conf
fi 

if [[ -n "$ROOTDN_PATH" ]]; then
  ROOTDN_CONTENT=`cat ${ROOTDN_PATH}`
  ROOTDNFULL=$ROOTDN_CONTENT","$SUFFIX_CONTENT
  sed -i "s/rootdn\t\t\"cn=Manager,dc=my-domain,dc=com\"/rootdn\t\t\"$ROOTDNFULL\"/" /etc/openldap/slapd.conf
fi 

if [[ -n "$ROOTPW_PATH" ]]; then
  ROOTPW_CONTENT=`cat ${ROOTPW_PATH}`
  sed -i "/rootpw/ d" /etc/openldap/slapd.conf
  echo "rootpw          $(slappasswd -s ${ROOTPW_CONTENT})" >> /etc/openldap/slapd.conf
fi 

echo "include         /etc/openldap/schema/cosine.schema" >> /etc/openldap/slapd.conf
echo "include         /etc/openldap/schema/inetorgperson.schema" >> /etc/openldap/slapd.conf
echo "include         /etc/openldap/schema/nis.schema" >> /etc/openldap/slapd.conf

cp /var/lib/openldap/openldap-data/DB_CONFIG.example /var/lib/openldap/openldap-data/DB_CONFIG

if [ ! -d "/run/openldap" ]; then mkdir -p /run/openldap; fi

if [ ! -d "/etc/openldap/ssl" ]; then mkdir -p /etc/openldap/ssl; fi

if [ ! -d "/etc/openldap/slapd.d" ]; then mkdir -p /etc/openldap/slapd.d; fi

if [ -f /etc/openldap/ssl/cert.pem ] && [ -f /etc/openldap/ssl/key.pem ]; then
  echo "add ssl config..."
  sh /etc/openldap/scripts/addtls.sh
fi

chown -R ldap:ldap /etc/openldap/slapd.d
rm -rf /etc/openldap/slapd.d/*
slaptest -u -f /etc/openldap/slapd.conf -F /etc/openldap/slapd.d/
echo "config inited."