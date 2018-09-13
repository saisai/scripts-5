# net_scan

This script was created to find out IP addresses assigned to up and running hosts.
It performs a network scan and writes in a file, IP addresses discovered during the run.

If the script is run more than once, it will ADD the IP addresses found during the execution of the script.

## How to use

Use the Linux cron or a systemd timer to run this script more than once. You will get
a file with a sorted a list of IP addresses used during a period of time.

The scrip does not need arguments.
