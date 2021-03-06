#!/bin/bash

find . -type f | xargs sed -i "s/\s*$//g"
