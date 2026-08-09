#!/bin/sh
DBEXISTS=$(MYSQL_PWD=$MYSQL_ROOT_PASSWORD mysql -uroot --batch --skip-column-names -e "SHOW DATABASES LIKE '"$MYSQL_DATABASE"';" | grep "$MYSQL_DATABASE" > /dev/null; echo "$?")
if [ $DBEXISTS -eq 0 ];then
    echo "A database with the name $MYSQL_DATABASE already exists."
#else
#  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET UTF8;"
#  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
#  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
#  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
fi
