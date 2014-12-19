set -e
sudo su

echo "Installing utils..."

yum install -y -q atool wget ping nano telnet

echo "Adding postgres repository..."

wget http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm

yum install -y -q pgdg-centos93-9.3-1.noarch.rpm

echo "Installing postgres ..."

yum install -y -q postgresql93-server

# echo "Installing pgpool-II ..."
# 
# wget http://www.pgpool.net/download.php?f=installer2-pg93-3.4.0.tar.gz -O installer2-pg93-3.4.0.tar.gz
# 
# aunpack installer2-pg93-3.4.0.tar.gz
# 
# cd installer2-pg93-3.4.0
# 
# yum install -y -q httpd php php-pgsql php-mbstring
# 
# USE_WATCHDOG=no ./install.sh

echo "Setup postreqs ..."

/etc/init.d/postgresql-9.3 initdb
chkconfig postgresql-9.3 on

echo "Start postreqs ..."

/etc/init.d/postgresql-9.3 start

echo "Create postreqs user ..."

cd /tmp

echo "CREATE USER root PASSWORD 'midtrans';"
sudo -u postgres psql -c "CREATE USER root PASSWORD 'midtrans';"

echo "CREATE DATABASE ridwan OWNER root;"
sudo -u postgres psql -c "CREATE DATABASE ridwan OWNER root;"

#echo "GRANT ALL ON SCHEMA ridwan TO root;"
#sudo -u postgres psql -c "GRANT ALL ON SCHEMA ridwan TO root;"

#exit

echo "Allow postreqs remote connections ..."

echo "" >> /var/lib/pgsql/9.3/data/postgresql.conf
echo "# Added by vagrant script:" >> /var/lib/pgsql/9.3/data/postgresql.conf
echo "listen_addresses='*'" >> /var/lib/pgsql/9.3/data/postgresql.conf

echo "" >> /var/lib/pgsql/9.3/data/pg_hba.conf
echo "# Added by vagrant script:" >> /var/lib/pgsql/9.3/data/pg_hba.conf
echo "host    all             all             192.168.3.0/24          md5" >> /var/lib/pgsql/9.3/data/pg_hba.conf

/etc/init.d/postgresql-9.3 restart