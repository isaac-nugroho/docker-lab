#!/bin/dumb-init /bin/sh
set -e

if [[ ! -d $MYSQL_DATA ]]; then
  mkdir -p $MYSQL_DATA
  chown -R mysql:mysql $MYSQL_DATA
fi

if [[ ! $(ls -A $MYSQL_DATA/) ]]; then
	sed -i 's;CHANGE_THIS_DEFAULT_PASSWORD;'$MARIADB_ROOT_PASSWORD';' /etc/login.cnf
	gosu mysql mysql_install_db --verbose --login-file=/etc/login.cnf --datadir="$MYSQL_DATA"
fi
set -- gosu mysql mysqld_safe --verbose "--datadir="$MYSQL_DATA "$@"

exec "$@"
