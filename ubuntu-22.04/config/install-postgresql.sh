# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-22-04
# remote access setup: https://blog.logrocket.com/setting-up-a-remote-postgres-database-server-on-ubuntu-18-04/
# using vector extension: https://supabase.com/docs/guides/database/extensions/pgvector


sudo apt update
sudo apt install postgresql postgresql-contrib
sudo apt install postgresql-server-dev-14
sudo apt install -y gcc
sudo apt install -y make
sudo systemctl start postgresql.service

sudo -u postgres createuser --interactive --pwprompt

# Configure for remote access

cp postgresql.conf /etc/postgresql/14/main/
cp pg_hba.conf /etc/postgresql/14/main/

sudo systemctl restart postgresql

# install vector extension for vector database embeddings
cd /home
git clone --branch v0.4.1 https://github.com/pgvector/pgvector.git
cd pgvector
make
make install

sudo -u postgres psql -c "CREATE EXTENSION vector"

