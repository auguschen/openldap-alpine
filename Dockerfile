FROM alpine:latest

LABEL maintainer="tianhao.chen@gmail.com"

RUN apk add --no-cache openldap openldap-back-mdb openldap-clients ca-certificates \
&& mkdir -p /scripts

COPY scripts/entrypoint.sh /scripts/entrypoint.sh

COPY scripts/initconf.sh /scripts/initconf.sh

COPY scripts/addtls.sh /scripts/addtls.sh

VOLUME [ "/etc/openldap", "/var/lib/openldap/openldap-data" ]

EXPOSE 389 636

ENTRYPOINT [ "sh", "/scripts/entrypoint.sh" ]