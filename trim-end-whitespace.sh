#!/bin/bash

find . -type f -not -path "./contents/*" | xargs sed -i "s/\s*$//g"
