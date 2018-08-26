#!/usr/bin/env sh
if [ ! -f /etc/openldap/.inited ]; then
  sh /etc/openldap/initconf.sh && touch /etc/openldap/.inited
fi

if [ -f /etc/openldap/cert.pem ] || [ -f /etc/openldap/key.pem ]; then
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