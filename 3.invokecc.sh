#!/bin/bash

# Exit on first error, print all commands.
set -e

# sample the temp, humpidity sensor, requires sudo access
eval "$(sudo -E go run ./sample.go cc)"
# store public ip
LOC=$("$(dig +short myip.opendns.com @resolver1.opendns.com)")
echo "$LOC", "$SAMPLE"

docker exec cli peer chaincode invoke -n samplecc -C mychannel -c '{"Args":["'"${LOC}"'", "'"${SAMPLE}"'"]}'