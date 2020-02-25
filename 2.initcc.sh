#!/bin/bash

# $1 is any arbitrary text version number not used before for this chaincode

# Exit on first error, print all commands.
set -e

# sample the temp, humpidity sensor, requires sudo access
eval "$(sudo -E go run ./sample.go cc)"
# store public ip
LOC=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo "$LOC", "$SAMPLE"

# instantiate or init
docker exec cli peer chaincode instantiate -n samplecc -v $10 -C mychannel -c '{"Args":["'"${LOC}"'", "'"${SAMPLE}"'"]}'
