#!/bin/sh

base=/Users/mhm/Projects/github.com/mlhartme/backup
. $HOME/.borg-profile

host=$(hostname)
date=$(date +"%y%m%d-%H%M%S")
root=/Users

trap 'echo ${date} Backup interrupted >&2; exit 2' INT TERM

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude sh:${root}/Shared/    \
    --exclude sh:${root}/*/Downloads  \
    --exclude sh:${root}/*/Library/Caches  \
    --exclude sh:${root}/*/Library/Logs \
    --exclude sh:${root}/*/Library/Group\ Containers/UBF8T346G9.Office \
    --exclude sh:${root}/*/Library/Application\ Support/SaalDesignSoftware \
    --exclude sh:${root}/*/Library/Application\ Support/minecraft \
    --exclude sh:${root}/*/Library/Containers/com.docker.docker \
    --exclude sh:${root}/*/Library/Safari \
    --exclude sh:${root}/*/Library/iTunes \
    --exclude sh:${root}/*/Pictures   \
    --exclude sh:${root}/*/.m2/repository   \
    --exclude sh:${root}/*/.cache     \
    --exclude sh:${root}/*/.fault     \
    --exclude sh:${root}/*/.Trash     \
    ::"${host}-${date}"             \
    ${root} >/var/log/borg/backup-${date}.log 2>&1

backup_exit=$?

borg prune                          \
    --list                          \
    --prefix "${host}-"             \
    --show-rc                       \
    --keep-daily    7               \
    --keep-weekly   4               \
    --keep-monthly  24              \

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    message="Backup ok"
    touch ${base}/ok
elif [ ${global_exit} -eq 1 ]; then
    message="Backup Warnings"
else
    message="Backup Failed"
fi
script="display alert \"${message}\" message \"${message}\""
echo ${script}
osascript -e "${script}"
exit ${global_exit}
