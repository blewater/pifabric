#!/bin/bash

# Exit on first error, print all commands.
set -e

# install chaincode on org1 peer0
docker exec cli peer chaincode install -n samplecc -v 0 -p github.com/samplecc