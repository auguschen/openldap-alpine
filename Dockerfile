FROM alpine:latest

LABEL maintainer="tianhao.chen@gmail.com"

RUN apk update \
&& apk add openldap openldap-back-mdb openldap-clients ca-certificates \
&& mkdir -p /etc/openldap/scripts

EXPOSE 389 636

COPY scripts/entrypoint.sh /etc/openldap/scripts/entrypoint.sh

COPY scripts/initconf.sh /etc/openldap/scripts/initconf.sh

COPY scripts/addtls.sh /etc/openldap/scripts/addtls.sh

VOLUME [ "/etc/openldap", "/var/lib/openldap/openldap-data" ]

ENTRYPOINT [ "sh", "/etc/openldap/scripts/entrypoint.sh" ]

CMD [ ]