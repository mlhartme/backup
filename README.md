# Borg Configuration

for https://www.borgbackup.org

## Setup

* clone this to /usr/local/backup
* install borg to /usr/local/bin

* TODO: still needed?
  * system preferences -> security -> full disk access:
    * /bin/sh!? to grant borg access to ~/Library stuff 
* TODO:
     add your passphrase with
        security add-generic-password -D secret -U -a $USER -s borg-passphrase -w $(echo "passphrase: "; read -s passphrase; echo $passphrase)
* create ~/.borg-profile
    export BORG_REPO=<your repo>
    ###export BORG_PASSCOMMAND="security find-generic-password -a $USER -s borg-passphrase -w"
    export BORG_PASSPHRASE=<yours>

* symlink launchd.plist into your /Library/LaunchdAgents

