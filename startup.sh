#!/bin/bash



ROOTPWD=${ROOT_PASSWORD:-"mariadb"}

if [ ! -d /var/lib/mysql/mysql ]; then
  mysql_install_db --user=mysql --rpm

  /usr/bin/mysqld --user=mysql --bootstrap --verbose=0 <<-EOF
	USE mysql;
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY "$ROOTPWD" WITH GRANT OPTION;
	GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
	UPDATE user SET password=PASSWORD("") WHERE user='root' AND host='localhost';
	FLUSH PRIVILEGES;
EOF
fi

MYSQL=( mysql --protocol=socket -uroot -hlocalhost -p"$ROOTPWD" )

if [ ! -z "$DATABASE" ]; then
    echo "Creating database: $DATABASE"
    echo "CREATE DATABASE IF NOT EXISTS \"$DATABASE\"" | "$MYSQL"

    if [ ! -z "$USER" != ]; then
      echo "GRANT ALL ON \"$DATABASE\".* to '$USER'@'%' IDENTIFIED BY '$PASSWORD';" | "$MYSQL"
    fi
fi

/usr/bin/mysqld_safe --user=mysql --log-error=error.log --datadir='/var/lib/mysql'

