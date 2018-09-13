sync_repo.sh
============

Description
-----------

This script syncs configuration files with a git repository and if there were changes in the configuration files,
it will commit and push those changes.

How to use
----------

1. Create a user to run this script (optional).
2. Set your SSH credentials with your remote repository to push without password prompt.
3. Copy the bash script into ``/usr/local/bin`` directory.
4. Modify the ``FILES_TO_SYNC`` variable (list) with the files and/or directories to track.
5. Modify the ``REPO_PATH`` variable with the local git repository path.
6. Create a systemd timer or a cron job to run this script.


Example
-------

.. code-block:: bash

    user@server01:~$ cat /etc/systemd/system/sync_repo.timer
    [Unit]
    Description=Run sync_repo.service all days
    
    [Timer]
    OnCalendar=*-*-* 00:05:00

    [Install]
    WantedBy=timers.target

    user@server01:~$ cat /etc/systemd/system/sync_repo.service
    [Unit]
    Description=Update and syncronize the git repository with the last configuration files

    [Service]
    Type=oneshot
    ExecStart=/bin/bash /usr/local/bin/sync_repo.sh
    User=git
    StandardOutput=journal


