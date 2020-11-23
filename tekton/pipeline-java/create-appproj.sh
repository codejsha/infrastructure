#!/bin/bash

UUID="$(uuidgen)"
SECONDS_SINCE="$(date +%s)"

sed -i "s/<UUID>/${UUID}/g" appproj.yaml
sed -i "s/<ISSUED_AT>/${SECONDS_SINCE}/g" appproj.yaml

kubectl apply --filename appproj.yaml
