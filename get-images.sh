#!/bin/bash

# Pull Raspberrypi4/3 fabric v1.4.4 images
# Tag them as hyperledger fabric for the default fabric script to use them

# orderer
docker pull blewater/fabric-orderer:fabric-1.4.4-raspberrypi4
docker tag blewater/fabric-orderer:fabric-1.4.4-raspberrypi4  blewater/fabric-orderer:latest
docker tag blewater/fabric-orderer hyperledger/fabric-orderer

# peer
docker pull blewater/fabric-peer:fabric-1.4.4-raspberrypi4
docker tag blewater/fabric-peer:fabric-1.4.4-raspberrypi4 blewater/fabric-peer:latest
docker tag blewater/fabric-peer:fabric-1.4.4-raspberrypi4 hyperledger/fabric-peer

# couchdb
docker pull blewater/fabric-couchdb:fabric-1.4.4-raspberrypi4
docker tag blewater/fabric-couchdb:fabric-1.4.4-raspberrypi4 blewater/fabric-couchdb:latest
docker tag blewater/fabric-couchdb:fabric-1.4.4-raspberrypi4 hyperledger/fabric-couchdb

# fabric-ca
docker pull blewater/fabric-ca:fabric-1.4.4-raspberrypi4
docker tag blewater/fabric-ca:fabric-1.4.4-raspberrypi4 blewater/fabric-ca:latest
docker tag blewater/fabric-ca:fabric-1.4.4-raspberrypi4 hyperledger/fabric-ca
