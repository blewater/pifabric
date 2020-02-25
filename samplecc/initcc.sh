#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error, print all commands.
set -e
# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1
starttime=$(date +%s)

# version of chaincode
CC_VERSION=${2:-"v0"}

# path of cli container
CC_SRC_PATH=/opt/gopath/src/github.com/sample

# install chaincode on org1 peer0
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n sample -v "$CC_VERSION" -p "$CC_SRC_PATH"
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n sample -v "$CC_VERSION" -p samplecc/sample.go

eval `go run ./sample.go`
LOC=$('uname -v')
echo $LOC, $SAMPLE

# invoke chaincode org1
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n sample -c '{"Args":["set", "'${LOC}'", "'${SAMPLE}'"]}'

peer chaincode install -p chaincodedev/chaincode/chaincode_example02/go -n mycc -v 0
peer chaincode instantiate -n mycc -v 0 -c '{"Args":["init","a","100","b","200"]}' -C myc

docker exec cli peer chaincode install -n sacc -v 0 -p github.com/sacc
docker exec cli peer chaincode instantiate -n sacc -v 0 -C mychannel -c '{"Args":["set", "'${LOC}'", "'${SAMPLE}'"]}'