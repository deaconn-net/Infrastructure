# Deaconn's Infrastructure & Deployment
## Description
Deaconn's infrastructure files for deployment. I use Docker Compose and `systemd` service files to run Deaconn. Inside of the Docker container, we use production methods such as `gunicorn` to run the web server project. The project also utilizes Django.

In regards to the `back-bone` respository, when a commit is ran on the `master` branch, it automatically restarts the `deaconn` service on the Linux VM I have it running on. When the service is started or restarted, it automatically pulls from the `master` branch (production).

## Installation
You may use `git` to clone the repository like the following.

```bash
# Clone the Deaconn infrastructure respository. If you want to use something other than '/var/deaconn', you will need change the Systemd and NGINX configuration files.
git clone https://github.com/Deaconn-net/Infrastructure.git /var/deaconn

# Change directories.
cd Infrastructure/
```

The next step is either modifying the `systemd` service if you're going to run that (recommended) or the `update_and_start.sh` file. You will want to replace and uncomment the environmental variables which includes database information and the Django security key.

Afterwards, you may use `make` to install the `systemd` service and the NGINX configuration (for Debian/Ubuntu-based systems; Automatically creates a symbolic link to `sites-enabled/` directory).

```bash
# Install the Systemd service.
sudo make install

# Installs the NGINX config.
sudo make nginx_install
```

From here, you may try starting up the application/web server with the following commands.

```bash
# Use the Systemd service (start and enable on startup).
sudo systemctl enable --now deaconn

# If you just want to start the service, you may do.
sudo systemctl start deaconn

# If you don't want to start the service, I'd recommend executing ./update_and_start.sh.
sudo ./update_and_start.sh

# For building/rebuilding the Docker image (no caching; full rebuild).
docker-compose build --no-cache
```

While Docker Compose & Docker *should* be handling the file permissions for certain volumes, I've found it doesn't no matter what I try on my VMs. The complicated part about the file permissions is they are applied on the host itself with Docker for good reason. You can execute the following command to give proper ownership, though.

```bash
sudo docker-compose run web chown -R deaconn:deaconn /deaconn
```

Finally, you'll want to make an administrator user so you can log into the admin panel at `http://website.com/admin`.

```bash
sudo docker-compose run web cd back-bone/deaconn/ && python manage.py createsuperuser
```

After you've logged into admin panel, you should be able to see additional options on the blog software where you can create blogs, comment, and more.

## Credits
* [Christian Deacon](https://github.com/gamemann)
