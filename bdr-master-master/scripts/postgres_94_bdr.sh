set -e -u

echo "Installing utils..."

echo "exclude=mirror.smartmedia.net.id, kartolo.sby.datautama.net.id" >> /etc/yum/pluginconf.d/fastestmirror.conf

yum install -y -q atool wget ping nano telnet

echo "Installing postgres..."

yum install -q -y http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-3.noarch.rpm
yum install -q -y http://packages.2ndquadrant.com/postgresql-bdr94-2ndquadrant/yum-repo-rpms/postgresql-bdr94-2ndquadrant-redhat-1.0-2.noarch.rpm

yum install -q -y postgresql-bdr94-bdr

echo "export PATH=/usr/pgsql-9.4/bin:$PATH" >> /etc/bashrc

export PATH=/usr/pgsql-9.4/bin:$PATH

echo "Init db ..."
sudo /usr/pgsql-9.4/bin/postgresql94-setup initdb -D /var/lib/pgsql/9.4-bdr/data -A trust -U postgres
