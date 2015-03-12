set -e -u

PG_DATABASE_NAME=${1:-bdr_database}

source /vagrant/scripts/postgres_94_bdr.sh

rm -f /var/lib/pgsql/9.4-bdr/data/pg_hba.conf
rm -f /var/lib/pgsql/9.4-bdr/data/postgresql.conf

cp /vagrant/master/pg_hba.conf /var/lib/pgsql/9.4-bdr/data/pg_hba.conf
cp /vagrant/master/postgresql.conf /var/lib/pgsql/9.4-bdr/data/postgresql.conf

sed -i "s/\$PG_DATABASE_NAME/${PG_DATABASE_NAME}/g" /var/lib/pgsql/9.4-bdr/data/postgresql.conf

chown postgres:postgres /var/lib/pgsql/9.4-bdr/data/pg_hba.conf
chown postgres:postgres /var/lib/pgsql/9.4-bdr/data/postgresql.conf

ln -s /var/lib/pgsql/9.4-bdr/data /database
cd /database


echo "Starting postgres ... "
sudo -u postgres -H sh -c "/usr/pgsql-9.4/bin/pg_ctl -D /var/lib/pgsql/9.4-bdr/data -l /database/logfile -w start"
sleep 2
sudo -u postgres -H sh -c "/usr/pgsql-9.4/bin/createdb $PG_DATABASE_NAME"
