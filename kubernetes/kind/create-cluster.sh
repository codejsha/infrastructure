#!/bin/bash

kind create cluster --name kind --config cluster.yaml
# kind create cluster --name kind --config cluster-ha.yaml
