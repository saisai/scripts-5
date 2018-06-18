#/bin/bash

#####################################################################
# Script Name   : sync_repo
# Description   : Update and syncronize the git repository with the
#                 last configuration files
# Args          : -
# Author        : Ary Kleinerman
# Email         : kleinerman@gmail.com
#####################################################################

COMMIT_MSG="Auto commit - $(date "+%Y%m%d %H:%M:%S")"

# List of files and directories to keep synced with the repository directory
FILES_TO_SYNC="
/etc/dhcp/dhcpd.conf \
/etc/dhcp/dhcpd.d
"
# Repository path directory
REPO_PATH=/home/git/dhcpd

RSYNC_CMD=$(rsync -aEim --delete $FILES_TO_SYNC $REPO_PATH)

# rsync command executed successfully
if [ $? -eq 0 ]; then
    # If rsync returns something, something changed.
    if [ -n "$RSYNC_CMD" ]; then
        # rsync has changes
	cd $REPO_PATH
        git add -A
	git commit -m "$COMMIT_MSG"
	git push origin master
    fi
# rsync command failed to execute
else
    echo "Error: rsync command failed to execute"
    exit 1
fi
