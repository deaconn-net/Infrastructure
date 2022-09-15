#!/bin/bash
# Import SSH key.
function run_cmd()
{
        ssh-agent bash -c "GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' $1"
}


# Check if we need to clone.
if [ ! -d "back-bone" ] ; then
        run_cmd "git clone git@github.com:Deaconn-net/back-bone.git"
fi

# Pull from remote.
cd back-bone/
git config pull.rebase false
run_cmd "git pull origin master"

# Collect files.
cd deaconn
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput --clear

# Start server.
gunicorn --bind unix:/deaconn/data/srv.sock deaconn.wsgi
