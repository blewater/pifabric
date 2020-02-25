#!/bin/bash

# optional upgrade chaincode after code changes to sourcecc/sourcecc.go

# $1 is any arbitrary text version number not used before for this chaincode

# don't forget to
# # cp ./samplecc/samplecc.go ../fabric-samples/chaincode/samplecc/
# cd ../fabric-samples/chaincode/samplecc/
# go build -o samplecc.go
# change v value to anything not used before

# Exit on first error, print all commands.
set -e

cp ./samplecc/samplecc.go ../fabric-samples/chaincode/samplecc/

# first you need to install with a different version
docker exec cli peer chaincode install -n samplecc -v $1 -p github.com/samplecc

# sample the temp, humpidity sensor, requires sudo access
eval "$(sudo -E go run ./sample.go cc)"
# store public ip
LOC=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo "$LOC", "$SAMPLE"

# upgrade with the installed version above
docker exec cli peer chaincode upgrade -n samplecc -v $1 -C mychannel -c '{"Args":["'"${LOC}"'", "'"${SAMPLE}"'"]}'
