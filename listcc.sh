#!/bin/bash

# Exit on first error, print all commands.
set -e

#list installed chaincodes
docker exec cli peer chaincode list --installed