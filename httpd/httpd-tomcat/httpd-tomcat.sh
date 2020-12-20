#!/bin/bash

HTTPD_HOME="/usr/local/httpd"

/usr/bin/cp -f mod-jk.conf uriworkermap.properties workers.properties ${HTTPD_HOME}
