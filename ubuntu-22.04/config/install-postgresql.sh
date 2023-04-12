# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-22-04
# remote access setup: https://blog.logrocket.com/setting-up-a-remote-postgres-database-server-on-ubuntu-18-04/
# using vector extension: https://supabase.com/docs/guides/database/extensions/pgvector

sudo apt update
sudo apt install -y postgresql postgresql-contrib
sudo apt install -y postgresql-server-dev-14
sudo apt install -y gcc
sudo apt install -y make
sudo apt install -y net-tools
sudo systemctl start postgresql.service

# Configure for remote access

cp postgresql.conf /etc/postgresql/14/main/
cp pg_hba.conf /etc/postgresql/14/main/

sudo systemctl restart postgresql

# IMPORTANT: Create user after restarting postgresql with new settings

sudo -u postgres createuser --interactive --pwprompt

# install vector extension for vector database embeddings
cd /home
git clone --branch v0.4.1 https://github.com/pgvector/pgvector.git
cd pgvector
make
make install

sudo -u postgres psql < /root/config/postgres.sql

ufw allow 22/tcp
ufw allow 5432/tcp
ufw enable

# sudo -u postgres psql

