#!/usr/bin/bash

USERNAME="admin"
PASSWORD="changeit"

curl --insecure --request GET --user ${USERNAME}:${PASSWORD} "https://registry.kube.example.com/v2/_catalog"
