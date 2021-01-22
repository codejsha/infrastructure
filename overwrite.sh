#!/bin/bash

git stash
git fetch --all
git reset --hard origin/main

# git restore --source=stash@{0} -- ./tomcat/helper.sh
# git restore --source=stash@{0} -- ./weblogic/helper.sh
# git restore --source=stash@{0} -- ./wildfly/helper.sh
