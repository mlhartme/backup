#!/bin/sh
log=/Users/mhm/Projects/github.com/mlhartme/backup/logs/check.log
env >${log}
find /Users/mhm/Library -type d >>${log} 2>&1
