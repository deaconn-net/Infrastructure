all: install nginx_install
install:
  cp -n systemd/deaconn.service /etc/systemd/system/
nginx_install:
  cp -n systemd/deaconn.conf /etc/nginx/sites-available
  ln -s /etc/nginx/sites-available/deaconn.conf /etc/nginx/sites-enabled/deaconn.conf