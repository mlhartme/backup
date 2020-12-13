#!/bin/sh

base=${HOME}/Projects/github.com/mlhartme/backup
. ${HOME}/.borg-profile

host=$(hostname)
date=$(date +"%y%m%d-%H%M%S")
root=${HOME}

trap 'echo ${date} Backup interrupted >&2; exit 2' INT TERM

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude ${root}/Downloads  \
    --exclude ${root}/Library/Caches  \
    --exclude ${root}/Library/Logs \
    --exclude ${root}/Library/Group\ Containers/UBF8T346G9.Office \
    --exclude ${root}/Library/Application\ Support/SaalDesignSoftware \
    --exclude ${root}/Library/Application\ Support/minecraft \
    --exclude ${root}/Library/Containers/com.docker.docker \
    --exclude ${root}/Library/Safari \
    --exclude ${root}/Library/iTunes \
    --exclude ${root}/Pictures   \
    --exclude ${root}/.m2/repository   \
    --exclude ${root}/.cache     \
    --exclude ${root}/.fault     \
    --exclude ${root}/.Trash     \
    --exclude ${base}/logs          \
    ::"${host}-${date}"             \
    ${root} >${base}/logs/backup-${date}.log 2>&1

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
