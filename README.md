# Borg Configuration

## Setup Backup Server

To Setup my backup server:

* create borg user
* install borg


## Setup a backup for a new machine

As mhm
* clone this to /usr/local/backup
* install borg (https://www.borgbackup.org) to /usr/local/bin 
  (dms file: chmod a+x, rename to borg)

As root
* create an ssh key without passphrase
    ssh-keygen -t rsa
  and add the public key to my borg account
* mkdir /var/log/borg
* create ~/.borg-profile
    export BORG_CLIENT=<yourhostname>
    export BORG_REPO=<your repo>
    export BORG_PASSPHRASE=<yours>
* create a new repo:
  * source profile
  * borg init --encryption=repokey
* cp <gitclone>/mlhartme.backup.plist /Library/LaunchdDaemons (not agents, that's per-user)
* launchctl load /Library/LaunchdDaemons/mlhartme.backup.plist
* check with launchctl list, tail /var/log/syslog.log
* launchctl start mlhartme.backup
* check tail /var/log/syslog.log and /var/log/borg

* for macOS Catalina:
  * system preferences -> security -> full disk access:
    * /bin/sh
