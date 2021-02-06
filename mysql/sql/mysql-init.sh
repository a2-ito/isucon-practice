#!/bin/sh
set -x
set -e
cd $(dirname $0)

myuser=root
mydb=isu4_qualifier
myhost=127.0.0.1
myport=3306
mypassword=isucon
mysql -h ${myhost} -P ${myport} -u ${myuser} -pisucon -e "DROP DATABASE IF EXISTS ${mydb}; CREATE DATABASE ${mydb}"
#docker exec -it -e myhost=${myhost} -e myport=${myport} -e myuser=${myuser} isucon-practice_isucon-mysql_1 bash -c 'mysql -h ${myhost} -P ${myport} -u ${myuser} -pisucon'
#docker exec -it -e myhost=${myhost} -e myport=${myport} -e myuser=${myuser} isucon-practice_isucon-mysql_1 bash -c 'mysql -h ${myhost} -P ${myport} -u ${myuser} -pisucon -e "DROP DATABASE IF EXISTS ${mydb}; CREATE DATABASE ${mydb}"'
mysql -h ${myhost} -P ${myport} -u ${myuser} -p${mypassword} ${mydb} < /sql/schema.sql
mysql -h ${myhost} -P ${myport} -u ${myuser} -p${mypassword} ${mydb} < /sql/dummy_users.sql
mysql -h ${myhost} -P ${myport} -u ${myuser} -p${mypassword} ${mydb} < /sql/dummy_log.sql
