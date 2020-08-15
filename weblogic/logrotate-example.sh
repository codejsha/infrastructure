#!/usr/bin/bash

cat <<EOF | sudo tee /etc/logrotate.d/weblogic_base_domain.conf
daily
rotate 4
create
dateext
notifempty
missingok

/usr/local/weblogic/user_projects/domains/base_domain/logs/*.out {
}

/usr/local/weblogic/user_projects/domains/base_domain/logs/*.log {
}
EOF
