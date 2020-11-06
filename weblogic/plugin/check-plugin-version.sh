#!/usr/bin/bash

PLUGIN_HOME="/svc/lib/weblogic-plugin"

strings ${PLUGIN_HOME}/lib/mod_wl.so | grep WLSPLUGINS
