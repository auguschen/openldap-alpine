FROM alpine:latest

LABEL maintainer="tianhao.chen@gmail.com"

RUN apk update \
&& apk add openldap openldap-back-mdb openldap-clients ca-certificates

EXPOSE 389 636

COPY scripts/entrypoint.sh /etc/openldap/entrypoint.sh

COPY scripts/initconf.sh /etc/openldap/initconf.sh

COPY scripts/addtls.sh /etc/openldap/addtls.sh

VOLUME [ "/etc/openldap", "/var/lib/openldap/openldap-data" ]

ENTRYPOINT [ "sh", "/etc/openldap/entrypoint.sh" ]

CMD [ ]