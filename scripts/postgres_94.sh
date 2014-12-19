set -e -u

sudo su

echo "Installing utils..."

yum install -y -q atool wget ping nano telnet

echo "Adding postgres repository..."

wget -q http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm

yum install -y -q pgdg-centos94-9.4-1.noarch.rpm

echo "Installing postgres ..."

yum install -y -q postgresql94-server

echo "Setup postreqs ..."

/etc/init.d/postgresql-9.4 initdb
chkconfig postgresql-9.4 on

echo "Start postreqs ..."

/etc/init.d/postgresql-9.4 start

echo "Create postreqs user ..."

cd /tmp

echo "CREATE USER root PASSWORD 'midtrans';"
sudo -u postgres psql -c "CREATE USER root PASSWORD 'midtrans';"

echo "CREATE DATABASE ridwan OWNER root;"
sudo -u postgres psql -c "CREATE DATABASE ridwan OWNER root;"

echo "Allow postreqs remote connections ..."

cat >> /var/lib/pgsql/9.4/data/postgresql.conf <<EOF

# Added by vagrant script:
listen_addresses='*'
EOF

cat >> /var/lib/pgsql/9.4/data/pg_hba.conf <<EOF

# Added by vagrant script:
host    all             all             192.168.3.0/24          md5
EOF

/etc/init.d/postgresql-9.4 restart