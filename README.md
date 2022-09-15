# Deaconn's Infrastructure
## Description
Deaconn's infrastructure files for deployment. I use Docker Compose and `systemd` service files to run Deaconn. 

When a commit is ran on the `master` branch, it automatically restarts the `deaconn` service on the Linux VM I have it running on. When the service is started or restarted, it automatically pulls from the `master` branch (production).

## Credits
* [Christian Deacon](https://github.com/gamemann)