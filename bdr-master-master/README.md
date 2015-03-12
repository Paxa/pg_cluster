Postgres 9.4 BDR master-master cluster
==========

> Bi-Directional Replication (BDR) is an asynchronous multi-master replication system for PostgreSQL,
> specifically designed to allow geographically distributed clusters.
> Supporting up to 48 nodes (and possibly more in future releases)
> BDR is a low overhead, low maintenance technology for distributed databases.

This is Vagrant config and shell script to setup BDR-cluster of 2 master nodes. Servers build on CentOS 6.5.


#### Run:

It uses CentOS 6.5 as a base image https://github.com/2creatives/vagrant-centos/releases/tag/v6.5.3

```shell
vagrant box add centos65-x86_64-20140116 https://github.com/2creatives/vagrant-centos/releases/download/v6.5.3/centos65-x86_64-20140116.box
git clone git@github.com:Paxa/pg_cluster.git
cd pg_cluster/bdr-master-master
vagrant up
# it can takes several minutes
```

You can configure database name in `Vagrantfile`:

```ruby
PG_DATABASE_NAME = "bdr_database"
```

#### Test connection:

```shell
# main node
psql -h 192.168.3.2 -U postgres -d bdr_database

# replica node
psql -h 192.168.3.3 -U postgres -d bdr_database

```

#### Test synchronization:

Try to create table and it will appear in other server:


```sql
psql -h 192.168.3.2 -U postgres -d bdr_database

CREATE TABLE people (
    id    serial primary key,
    name        VARCHAR(40) not null,
    birthdate        DATE
);

INSERT INTO people (name,birthdate) VALUES ('Alice', '1985-05-01'), ('Bob','1984-05-02');
```

On other server:

```sql
psql -h 192.168.3.3 -U postgres -d bdr_database

select * from people;
```

-----

I use shell scripts for provisioning to easily run it on server later.