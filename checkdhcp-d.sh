#!/bin/bash
#
# Making sure the log file exists...
#
touch /var/log/dhcp-d-restart.log
#
# Making sure the dhcpd daemon wasn't shutdown administratively...
#
FILE=/usr/local/sbin/dhcpd-shutdown-administratively.txt
if [[ -e $FILE ]] ; then
        echo "$(date) Daemon was administratively shutdown.  " >> /var/log/dhcp-d-restart.log
else
#
# Get the process id of the dhcpd process...
#
        /sbin/pidof dhcpd >/dev/null
 #
 # Test the exit status of the last command...
 #
        if [[ $? -ne 0 ]] ; then
                echo "$(date) Restarting dhcp-d " >> /var/log/dhcp-d-restart.log
                /usr/local/sbin/dhcpd &
                mailx -s "DHCP daemon process problems..." user@domain.com < /var/log/dhcp-d-restart.log
        else
                echo "$(date) All is well with dhcp-d-daemon. " >> /var/log/dhcp-d-restart.log
        fi ;
fi ;
