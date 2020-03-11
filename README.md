# Borg Configuration

## Setup

* system preferences -> security -> full disk access:
  * /bin/sh!? to grant borg access to ~/Library stuff 
* add your passphrase with
    security add-generic-password -D secret -U -a $USER -s borg-passphrase -w $(echo "passphrase: "; read -s passphrase; echo $passphrase)
* source profile in your ~/.zprofile
* symlink launchd.plist into your ~/Library/Launchd

