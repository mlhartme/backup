# Borg Configuration

## Setup

* add your passphrase with
    security add-generic-password -D secret -U -a $USER -s borg-passphrase -w $(echo "passphrase: "; read -s passphrase; echo $passphrase)
* source profile in your ~/.zprofile
* symlink launchd.plist into your ~/Library/Launchd
