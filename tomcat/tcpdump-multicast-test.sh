#!/bin/bash

sudo tcpdump -ni eth0 host 228.0.0.4
sudo tcpdump -ni eth0 tcp port 4000
