#!/bin/bash

################################################
# Script Name   : rsync_backup
# Description   : Incremental backup with rsync
# Args          : -
# Author        : Ary Kleinerman
# Email         : kleinerman@gmail.com
################################################

# Commands
RSYNC=/usr/bin/rsync
SSH=/usr/bin/ssh
MKDIR=/bin/mkdir
RMDIR=/bin/rmdir

# Remote server and user (for SSH)
RHOST=dax.capitalinasdc.com
RUSER=root

# Directories to backup
LPATH="/etc/apache2/sites-available \
/var/www/red.capitalinasdc.com \
/var/www/soporte.capitalinasdc.com \
/var/www/racktables.capitalinasdc.com"

################################################

WDAY=`date +%A`
HOSTNAME=`hostname`

BACKUPDIR=/root/backups/${HOSTNAME}/${WDAY}
RPATH=/root/backups/${HOSTNAME}/current

OPTS="-z -e ${SSH} --force --ignore-errors --delete --backup --backup-dir=${BACKUPDIR} -a"

# the following lines clear the last weeks incremental directory
EMPTYDIR=`mktemp -d`
${RSYNC} -e ${SSH} --delete -a ${EMPTYDIR} ${RUSER}@${RHOST}:${BACKUPDIR}/
${RMDIR} ${EMPTYDIR}

# rsync the current local path
${RSYNC} ${OPTS} ${LPATH} ${RUSER}@${RHOST}:${RPATH}
