#!/bin/bash

databases="$(printenv | grep MYSQL_DATABASE_ | cut -d = -f 2)"

set -f 

array=(${databases// / })

for i in "${!array[@]}"
do
    # echo ${array[i]};
    echo "CREATE DATABASE ${array[i]}" | mysql -u root -p$MYSQL_ROOT_PASSWORD
    echo "GRANT ALL PRIVILEGES ON ${array[i]}.* TO 'user'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'" | mysql -u root -p$MYSQL_ROOT_PASSWORD
    echo "GRANT ALL PRIVILEGES ON ${array[i]}.* TO 'user'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD'" | mysql -u root -p$MYSQL_ROOT_PASSWORD
done
