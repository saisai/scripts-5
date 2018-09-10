#!/bin/sh

#####################################################################
# Script Name   : rsync_backup
# Description   : Incremental backup with rsync
# Args          : -
# Author        : Ary Kleinerman
# Email         : kleinerman@gmail.com
#####################################################################

RSYNC=/usr/bin/rsync
SSH=/usr/bin/ssh
MKDIR=/bin/mkdir
RMDIR=/bin/rmdir

# Remote server and user (for SSH)
RHOST=dax.capitalinasdc.com
RUSER=root

# Directories to backup
DIR="/etc/apache2/sites-available \
/var/www/site1.example.org \
/var/www/site2.example.org \
/var/www/site3.example.org"

########################################################################

WDAY=`date +%A`
HOSTNAME=`hostname`
BACKUPDIR=/root/backups/${HOSTNAME}/${WDAY}
REMOTEDIR=/root/backups/${HOSTNAME}/current

OPTS="-z -e ${SSH} --force --ignore-errors --delete --backup --backup-dir=${BACKUPDIR} -a"

# the following line clears the last weeks incremental directory
[ -d /tmp/emptydir ] || ${MKDIR} /tmp/emptydir
${RSYNC} -e ${SSH} --delete -a /tmp/emptydir/ ${RUSER}@${RHOST}:${BACKUPDIR}/
${RMDIR} /tmp/emptydir

# now the actual transfer
${RSYNC} ${OPTS} ${DIR} ${RUSER}@${RHOST}:${REMOTEDIR}
