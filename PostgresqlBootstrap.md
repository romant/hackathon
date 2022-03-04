# Postgresql

Postgres is a 100% open source Object-Relational Database Management System (ORDBMS) that supports a large part of the SQL standard.
VMware Postgres is based on the PostgreSQL source code published at https://www.postgresql.org and other PostgreSQL software.

We can do simple bootstrap on Postgresql by following below instructions. This script developed for AWS environment. 

## *Pre-requisites:*

- AWC EC2 Instance with either Amazon Linux 2 AMI or RHEL 8
- Postgresql server is part of Amazon Linux 2 AMI OS
- create a directory named "psql[mkdir /home/ec2-user/psql]" and Copy below script to your AWS home directory:/home/ec2-user/psql

### Postgressql Bootstrap Script
Need to copy below script to AWS EC2 instance on home directory:
  - [PostgreSQL Main Bootstrap Script](https://github.com/romant/hackathon/blob/main/psql_install.sh)
  - [PostgreSQL pg_hba.conf](https://github.com/romant/hackathon/blob/main/pg_hba.conf)
  - [PostgreSQL Startup Script](https://github.com/romant/hackathon/blob/main/startup.sql)


Run it as normal script:
- bash psql_install.sh -

The bootstrap script will run below events:


Cleanup previous installation
Install Postgresql
Initialize the DB
Start the Database
Show the running DB service
Expected output:

```
* Complete!
Running initdb
Initializing database ... OK

Starting PostgreSQL
Created symlink from /etc/systemd/system/multi-user.target.wants/postgresql.service to /usr/lib/systemd/system/postgresql.service.
Wait for PostgreSQL to finish starting up...
Running script
CREATE ROLE
CREATE DATABASE
You are now connected to database "hello_postgres" as user "psqluser".
CREATE TABLE
INSERT 0 1
Querying the newly created table in the newly created database.
 tag_name | tag_value
----------+------------
 Hello    | Postgresql
(1 row) *
```
## Setup completed.
