net_scan
========

This script was created to find out used IPs in a large network.
It performs a network scan and writes in a file IPs discovered that are being used in that moment.

If the script is run more than onece, it will ADD IP addresses found during the execution of the script.

How to use
----------

Use the Linux cron or a systemd timer to run this script more than once. You will get
a file with a sorted a list of IP addresses used during this period.

The scrip does not need arguments.
