# Borg Configuration

for https://www.borgbackup.org

## Setup

* clone this to /usr/local/backup
* install borg to /usr/local/bin 
  (dms file: chmod a+x, rename to borg)
* as root
  * create an ssh key without passphrase
    ssh-keygen -t rsa
    and add the public key to my borg account
* create ~/.borg-profile
    export BORG_REPO=<your repo>
    ###export BORG_PASSCOMMAND="security find-generic-password -a $USER -s borg-passphrase -w"
    export BORG_PASSPHRASE=<yours>
* to create a new repo: 
  * source profile
  * borg init --encryption=repokey
* cp launchd.plist into your /Library/LaunchdDaemons (not agents, that's per-user)
* check with launchctl list

* TODO: still needed?
  * system preferences -> security -> full disk access:
    * /bin/sh!? to grant borg access to ~/Library stuff 
  * TODO:
     add your passphrase with
        security add-generic-password -D secret -U -a $USER -s borg-passphrase -w $(echo "passphrase: "; read -s passphrase; echo $passphrase)
