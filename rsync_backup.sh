#!/bin/sh

# Remote server and user (for SSH)
SERVER=dax.capitalinasdc.com
RUSER=root

# Directories to backup
DIR="/etc/apache2/sites-available \
/var/www/red.capitalinasdc.com \
/var/www/soporte.capitalinasdc.com \
/var/www/racktables.capitalinasdc.com"

############################################

WDAY=`date +%A`
HOSTNAME=`hostname`
BACKUPDIR=/root/backups/${HOSTNAME}/${WDAY}
REMOTEDIR=/root/backups/${HOSTNAME}/current

OPTS="-e ssh --force --ignore-errors --delete --backup --backup-dir=${BACKUPDIR} -a"

# the following line clears the last weeks incremental directory
[ -d /tmp/emptydir ] || mkdir /tmp/emptydir
rsync -e ssh --delete -a /tmp/emptydir/ ${RUSER}@${SERVER}:${BACKUPDIR}/
rmdir /tmp/emptydir

# now the actual transfer
rsync ${OPTS} ${DIR} ${RUSER}@${SERVER}:${REMOTEDIR}
