#!/bin/sh

base=${HOME}/Projects/github.com/mlhartme/backup
. ${base}/profile

host=walter
date=$(date +"%y%m%d-%H%M%S")

trap 'echo ${date} Backup interrupted >&2; exit 2' INT TERM

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude /Users/mhm/Downloads  \
    --exclude /Users/mhm/Library/Caches  \
    --exclude /Users/mhm/Pictures   \
    --exclude /Users/mhm/.m2/repository   \
    --exclude /Users/mhm/.cache     \
    --exclude /Users/mhm/.fault     \
    --exclude /Users/mhm/.Trash     \
    --exclude ${base}/logs          \
    ::"${host}-${date}"             \
    /Users/mhm >${base}/logs/backup-${date}.log 2>&1

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
    message="Finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    message="Finished with warnings"
else
    message="Finished with errors"
fi
script="display alert "Backup Done" message \"${message}\""
echo ${script}
osascript -e "${script}"
exit ${global_exit}
