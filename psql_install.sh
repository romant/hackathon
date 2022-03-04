echo "cleaning up PostgreSQL"
sudo systemctl start postgresql
sudo yum remove -y postgresql-server postgresql-contrib
sudo rm -rf /var/lib/pgsql/data
echo "installing PostgreSQL"
sudo yum install -y postgresql-server postgresql-contrib
echo "Running initdb"
sudo postgresql-setup initdb
sudo cp -rp /home/ec2-user/psql/pg_hba.conf /var/lib/pgsql/data
echo "Starting PostgreSQL"
sudo systemctl start postgresql
sudo systemctl enable postgresql

# This block adds the environment variables for PostgreSQL to /etc/profile in order to set them for all users.
#echo "Writing PostgreSQL environment variables to /etc/profile"
#cat << EOL | sudo tee -a /etc/profile
# PostgreSQL Environment Variables
#LD_LIBRARY_PATH=/postgres/lib
#export LD_LIBRARY_PATH
#PATH=/postgres/bin:$PATH
#export PATH
#EOL

echo "Wait for PostgreSQL to finish starting up..."
sleep 5

# The startup.sql script is ran to create the user, database, and populate the database.
echo "Running script"
helloscript='/home/ec2-user/psql/startup.sql'
psql -U postgres -f $helloscript

# hello_postgres is queried

echo "Querying the newly created table in the newly created database."
psql -c 'select * from hello;' -U psqluser hello_postgres;
