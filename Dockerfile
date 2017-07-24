FROM alpine:latest

MAINTAINER Thierry VOYAT <thierry.voyat@ac-amiens.fr>

RUN apk update \
    && apk add tzdata && cp /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && echo "Europe/Paris" >  /etc/timezone \
    && apk del tzdata \
    && apk add bash \
       mariadb \
       mariadb-client \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /run/mysqld && chown mysql. /run/mysqld \
    && ln -sfT /dev/stderr "/var/lib/mysql/error.log" 

COPY startup.sh /

WORKDIR /var/lib/mysql
VOLUME /var/lib/mysql

EXPOSE 3306

CMD ["/startup.sh"]
