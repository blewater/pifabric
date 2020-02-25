#!/bin/bash

# $1 is any arbitrary text version number not used before for this chaincode

# Exit on first error, print all commands.
set -e

# install chaincode on org1 peer0
docker exec cli peer chaincode install -n samplecc -v $1 -p github.com/samplecc