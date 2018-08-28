#!/usr/bin/env sh
if [ ! -f /etc/openldap/.inited ]; then
  echo "conatiner running up first time."
  sh /etc/openldap/scripts/initconf.sh && touch /etc/openldap/.inited
fi

if [ -f /etc/openldap/ssl/cert.pem ] && [ -f /etc/openldap/ssl/key.pem ] && [ -f /etc/openldap/ssl/chain.pem ]; then
  if [[ -n "$ERRLVL" ]]; then
    /usr/sbin/slapd -d $ERRLVL -h "ldap:/// ldaps:///"
  else
    /usr/sbin/slapd -d 256 -h "ldap:/// ldaps:///"
  fi
else
  if [[ -n "$ERRLVL" ]]; then
    /usr/sbin/slapd -d $ERRLVL
  else
    /usr/sbin/slapd -d 256
  fi
fi