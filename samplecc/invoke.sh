#!/bin/bash

eval `go run ./sample.go`
LOC=$('uname -v')
echo $LOC, $SAMPLE
docker exec cli peer chaincode invoke -n sacc -C mychannel -c '{"Args":["set", "'${LOC}'", "'${SAMPLE}'"]}'