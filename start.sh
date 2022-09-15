#!/bin/bash

# Check if we need to clone.
if [ ! -d "back-bone" ] ; then
        git clone https://github.com/Deaconn-net/back-bone
fi

# Pull from remote.
cd back-bone/

# Make sure we're in a Git directory. If not, force rewrite.
git status

if [ $? -ne 0 ]; then
        rm -rf back-bone
        git clone https://github.com/Deaconn-net/back-bone
        cd back-bone
fi

git config pull.rebase false
git pull origin master

# Collect files.
cd deaconn
python manage.py makemigrations --noinput
python manage.py migrate --noinput
python manage.py collectstatic --noinput --clear

# Start server.
gunicorn --bind unix:/deaconn/data/srv.sock deaconn.wsgi