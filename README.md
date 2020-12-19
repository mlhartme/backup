# Borg Configuration

for https://www.borgbackup.org

## Setup

As mhm
* clone this to /usr/local/backup
* install borg to /usr/local/bin 
  (dms file: chmod a+x, rename to borg)

As root
* create an ssh key without passphrase
    ssh-keygen -t rsa
  and add the public key to my borg account
* mkdir /var/log/borg
* create ~/.borg-profile
    export BORG_REPO=<your repo>
    export BORG_PASSPHRASE=<yours>
* create a new repo:
  * source profile
  * borg init --encryption=repokey
* cp <gitclone>/launchd.plist into your /Library/LaunchdDaemons (not agents, that's per-user)
* launchctl load backup.plist
* check with launchctl list, tail /var/log/syslog.log

* TODO: still needed?
  * system preferences -> security -> full disk access:
    * /bin/sh!? to grant borg access to ~/Library stuff 
  * TODO:
     add your passphrase with
        security add-generic-password -D secret -U -a $USER -s borg-passphrase -w $(echo "passphrase: "; read -s passphrase; echo $passphrase)
