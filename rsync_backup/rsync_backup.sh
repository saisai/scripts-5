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
RHOST=remote.example.org
RUSER=root

# Directories to backup
LPATH="/path/to/files1 \
/path/to/files2 \
/path/to/files3"

################################################

WDAY=`date +%A`
HOSTNAME=`hostname`

BACKUPDIR=/root/backups/${HOSTNAME}/${WDAY}
RPATH=/root/backups/${HOSTNAME}/current

OPTS="-z -e ${SSH} --force --ignore-errors --delete --backup --backup-dir=${BACKUPDIR} -a -R"

# the following lines clear the last weeks incremental directory
EMPTYDIR=`mktemp -d`
${RSYNC} -e ${SSH} --delete -a ${EMPTYDIR}/ ${RUSER}@${RHOST}:${BACKUPDIR}/
${RMDIR} ${EMPTYDIR}

# rsync the current local path
${RSYNC} ${OPTS} ${LPATH} ${RUSER}@${RHOST}:${RPATH}
