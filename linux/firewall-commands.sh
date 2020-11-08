######################################################################

### status firewalld

systemctl status firewalld

######################################################################

### enable/disable firewalld

systemctl enable firewalld
systemctl disable firewalld

######################################################################

### start/stop firewalld

systemctl start firewalld
systemctl stop firewalld

######################################################################

### add/remove zone

firewall-cmd --get-default-zone
firewall-cmd --get-active-zone

firewall-cmd --permanent --new-zone=webserver
firewall-cmd --reload

firewall-cmd --permanent --delete-zone=webserver
firewall-cmd --reload

######################################################################

### add/remove ports

firewall-cmd --permanent --zone=public --add-port=7001/tcp
firewall-cmd --permanent --zone=public --add-port=7000-7999/tcp
firewall-cmd --reload

firewall-cmd --permanent --zone=public --remove-port=7001/tcp
firewall-cmd --permanent --zone=public --remove-port=7000-7999/tcp
firewall-cmd --reload

######################################################################

### add/remove service

firewall-cmd --permanent --zone=public --add-service=cockpit.socket
firewall-cmd --reload

firewall-cmd --permanent --zone=public --remove-service=cockpit.socket
firewall-cmd --reload

######################################################################

### list

firewall-cmd --permanent --list-all --zone=public
