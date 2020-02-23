#!/bin/bash
# download generated images and tag as the hyperledger ones

# orderer
docker pull blewater/fabric-orderer
docker tag blewater/fabric-orderer hyperledger/fabric-orderer 

# peer
docker pull blewater/fabric-peer
docker tag blewater/fabric-peer hyperledger/fabric-peer

# couchdb
docker pull blewater/fabric-couchdb
docker tag blewater/fabric-couchdb hyperledger/fabric-couchdb

# fabric-ca
docker pull blewater/fabric-ca
docker tag blewater/fabric-ca hyperledger/fabric-ca

# buildenv
docker pull blewater/fabric-buildenv
docker tag blewater/fabric-buildenv hyperledger/fabric-buildenv

# fabric-tools
docker pull blewater/fabric-tools
docker tag blewater/fabric-tools hyperledger/fabric-tools

# fabric-kafka
docker pull blewater/fabric-kafka
docker tag blewater/fabric-kafka hyperledger/fabric-kafka

# fabric-baseos
docker pull blewater/fabric-baseos
docker tag blewater/fabric-baseos hyperledger/fabric-baseos

# fabric-baseimage
docker pull blewater/fabric-baseimage
docker tag blewater/fabric-baseimage hyperledger/fabric-baseimage

# fabric-ccenv
docker pull blewater/fabric-ccenv
docker tag blewater/fabric-ccenv hyperledger/fabric-ccenv

# fabric-zookeeper
docker pull blewater/fabric-zookeeper
docker tag blewater/fabric-zookeeper hyperledger/fabric-zookeeper
