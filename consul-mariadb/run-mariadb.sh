#!/bin/dumb-init /bin/sh
set -e

if [[ ! -d $MARIADB_DATA ]]; then
  mkdir -p $MARIADB_DATA
  chown -R mysql:mysql $MARIADB_DATA
fi

if [[ $(ls -A $MARIADB_DATA/) ]]; then
	sed -i 's;CHANGE_THIS_DEFAULT_PASSWORD;'$MARIADB_ROOT_PASSWORD';' /etc/login.cnf
	gosu mysql mysql_install_db --verbose --login-file=/etc/login.cnf "--datadir="$MARIADB_DATA
fi
set -- gosu mysql mysqld_safe --verbose "--datadir="$MARIADB_DATA "$@"

exec "$@"
