#!/bin/sh
usersList="Oleksandr.Rusakevych Vladyslav.Diadyk Artem.Tsyhanov Andrii.Avseienko Roman.Savitskiy Olha.Skrypnyk Lev.Hlushchenko Serhii.Baranovskyi"

DBEXISTS=$(MYSQL_PWD=$MYSQL_ROOT_PASSWORD mysql -uroot --batch --skip-column-names -e "SHOW DATABASES LIKE '"$MYSQL_DATABASE"';" | grep "$MYSQL_DATABASE" > /dev/null; echo "$?")
if [ $DBEXISTS -eq 0 ];then
    echo "A database with the name $MYSQL_DATABASE already exists."
else
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE CHARACTER SET UTF8;"
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
fi

for userName in $usersList; do
  userPass=$(echo $userName | base64 | head -c 10)
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$userName'@'%' IDENTIFIED WITH caching_sha2_password BY '$userPass';"
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$userName'@'%';"
done
mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"

DB_NAME='api'
DBEXISTS=$(MYSQL_PWD=$MYSQL_ROOT_PASSWORD mysql -uroot --batch --skip-column-names -e "SHOW DATABASES LIKE '"$DB_NAME"';" | grep "$DB_NAME" > /dev/null; echo "$?")
if [ $DBEXISTS -eq 0 ];then
    echo "A database with the name $DB_NAME already exists."
else
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET UTF8;"
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$MYSQL_USER'@'%';"
  mysql -uroot -p"$MYSQL_ROOT_PASSWORD" -e "FLUSH PRIVILEGES;"
fi
