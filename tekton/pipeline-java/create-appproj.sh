#!/bin/bash

export UUID="$(uuidgen)"
export SECONDS_SINCE="$(date +%s)"

envsubst < ./appproj.yaml > ./appproj-temp.yaml

kubectl apply --filename appproj-temp.yaml
