#!/bin/sh

#####################################################################
# Script Name   : rsync_backup
# Description   : Incremental backup with rsync
# Args          : -
# Author        : Ary Kleinerman
# Email         : kleinerman@gmail.com
#####################################################################

# Remote server and user (for SSH)
SERVER=remote.example.org
RUSER=root

# Directories to backup
DIR="/etc/apache2/sites-available \
/var/www/site1.example.org \
/var/www/site2.example.org \
/var/www/site3.example.org"

############################################

WDAY=`date +%A`
HOSTNAME=`hostname`
BACKUPDIR=/root/backups/${HOSTNAME}/${WDAY}
REMOTEDIR=/root/backups/${HOSTNAME}/current

OPTS="-e ssh --force --ignore-errors --delete --backup --backup-dir=${BACKUPDIR} -a"

# the following lineis clear the last weeks incremental directory
[ -d /tmp/emptydir ] || mkdir /tmp/emptydir
rsync -e ssh --delete -a /tmp/emptydir/ ${RUSER}@${SERVER}:${BACKUPDIR}/
rmdir /tmp/emptydir

# Current backup
rsync ${OPTS} ${DIR} ${RUSER}@${SERVER}:${REMOTEDIR}
