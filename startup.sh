#!/bin/bash


if [ ! -d /run/mysqld ]; then
   mkdir /run/mysqld && chown mysql. /run/mysqld
fi

if [ ! -d /var/lib/mysql/mysql ]; then
   mysql_install_db --user=mysql --rpm
   ROOTPWD=${ROOT_PASSWORD:-"mariadb"}
   if [ ! -z "$DATABASE" ]; then
      CREATE="CREATE DATABASE IF NOT EXISTS $DATABASE;"
      if [ ! -z "$USER" ]; then
         GRANT="GRANT ALL PRIVILEGES ON $DATABASE.* to '$USER'@'localhost' IDENTIFIED BY '$PASSWORD';"
         GRANT1="GRANT ALL PRIVILEGES ON $DATABASE.* to '$USER'@'%' IDENTIFIED BY '$PASSWORD';"
      fi
   fi
   /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 <<-EOF
      USE mysql;
      FLUSH PRIVILEGES;
      GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$ROOTPWD" WITH GRANT OPTION;
      GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
      UPDATE user SET password=PASSWORD("$ROOTPWD") WHERE user='root' AND host='localhost';
      $CREATE
      $GRANT
      $GRANT1
      FLUSH PRIVILEGES;
EOF
fi

/usr/bin/mysqld_safe --user=mysql --log-error=error.log --datadir='/var/lib/mysql'

