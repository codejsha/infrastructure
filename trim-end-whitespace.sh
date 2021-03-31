#!/bin/bash

find . -type f -not \( -path "./.git/*" -o -path "./contents/*" \) | xargs sed -i "s/\s*$//g"
