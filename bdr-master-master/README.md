pg_cluster
==========

This is vagrant config and shell script for Postgres 9.4 BDR cluster

It creates 2 VMs and setup a master-master replication.

#### Run:

It uses CentOS 6.5 as a base image https://github.com/2creatives/vagrant-centos/releases/tag/v6.5.3

```shell
vagrant box add centos65-x86_64-20140116 https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box
git clone git@github.com:Paxa/pg_cluster.git
cd pg_cluster/bdr-master-master
vagrant up
# it can takes several minutes

# main node
psql -H 192.168.3.2 -U postgres

# replica node
psql -H 192.168.3.3 -U postgres

```

I use shell scripts for provisioning to easily run it on server later.