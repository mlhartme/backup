# Borg Configuration

for https://www.borgbackup.org

## Setup

* install borg to /usr/local/bin
* system preferences -> security -> full disk access:
  * /bin/sh!? to grant borg access to ~/Library stuff 
* add your passphrase with
    security add-generic-password -D secret -U -a $USER -s borg-passphrase -w $(echo "passphrase: "; read -s passphrase; echo $passphrase)
* create ~/.borg-profile
    export BORG_REPO=<your repo>
    export BORG_PASSCOMMAND="security find-generic-password -a $USER -s borg-passphrase -w"
  and optionally source it in your ~/.zprofile

* symlink launchd.plist into your ~/Library/Launchd

