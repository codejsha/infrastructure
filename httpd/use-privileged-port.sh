#!/usr/bin/bash

HTTPD_HOME="/usr/local/httpd"

sudo chown root ${HTTPD_HOME}/bin/httpd
sudo chmod 6750 ${HTTPD_HOME}/bin/httpd
