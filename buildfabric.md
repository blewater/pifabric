# Optional Building the Hyperledger Fabric Images for 64-bit ARM devices
Please note these images are already available at [Docker Images](https://hub.docker.com/r/blewater).

For the general Fabric setup guide for RaspberryPi4 is [here](README.md)

## Getting Started

* clone the Fabric codebase
```
mkdir -p ~/go/src/github.com/hyperledger/

cd ~/go/src/github.com/hyperledger/

git clone https://github.com/hyperledger/fabric
git clone https://github.com/hyperledger/fabric-ca
git clone https://github.com/hyperledger/fabric-samples
git clone https://github.com/hyperledger/fabric-baseimage
git clone https://github.com/hyperledger/fabric-chaincode-go

```

## Building the 3rd party base images (CouchDB, Kakfa, Zookeeper)

```
sudo apt install make #install make

# install this guide's ARM patch
git clone https://github.com/blewater/pifabric

# patch fabric-baseimage with ARM64 changes
cp -r ./pifabric/fabric-baseimage/* ./fabric-baseimage/

```
*[Credit for the couchdb Dockerfile changes](https://jira.hyperledger.org/browse/FAB-11912)*
```

cd fabric-baseimage

git status 
# should display the following patched changes
```
![image of git changes](./base-images-changes.png)

nano Makefile
on line 78,79 enter your dockerhub credentials

    --username=blewater \
    --password=xxxxxxxxxx \

### Start the lengthy build process

```
make all

# This is a lengthy build process
# and mostly a single ARM cpu affair
```

At the build completion (about 2 hours) you should 3 images built successfully
```
Successfully tagged hyperledger/fabric-zookeeper:latest
docker tag hyperledger/fabric-zookeeper hyperledger/fabric-zookeeper:arm64-0.4.19-snapshot-c84155e
```

## Building the Fabric images (peer, orderer, ccenv, buildenv, tools)
```
# run these to add a clean 0.4.18 tag to the generated images
docker tag hyperledger/fabric-baseos hyperledger/fabric-baseos:arm64-0.4.18
docker tag hyperledger/fabric-baseimage hyperledger/fabric-baseimage:arm64-0.4.18
docker tag hyperledger/fabric-couchdb hyperledger/fabric-couchdb:arm64-0.4.18
docker tag hyperledger/fabric-zookeeper hyperledger/fabric-zookeeper:arm64-0.4.18
docker tag hyperledger/fabric-kafka hyperledger/fabric-kafka:arm64-0.4.18
```
```
git checkout release-1.4
```
### In these 3 files
        examples/cluster/config/core.yaml
        integration/nwo/core_template.go
        sampleconfig/core.yaml
### Search for *Memory: 2147483648* and edit it to this
##### Credit goes to [Artem Barger's stackoverflow answer](https://stackoverflow.com/questions/45800167/hyperledger-fabric-on-raspberry-pi-3) 
```
Memory: 16777216
```
Ignore other suggested changes and **leave useLeaderElection to default value of true**. 

useLeaderElection: **true**

```
#install gcc
sudo apt install -y gcc

# now run
make docker
sudo cp .build/bin/* /usr/local/bin
```

## Building fabric-ca client server
```
cd ../fabric-ca
git checkout release-1.4
```

#### Edit Makefile with replace amd64 to arm64 for linux
#### Or run the following
```
cp ../pifabric/fabric-ca/Makefile ./

make docker
```

### Push the docker images to your hub
```
cd ../fabric
# tag images as latest
make docker-tag-latest

# tag them with your repo
# i.e. docker tag hyperledger/fabric-baseos blewater/fabric-baseos

# check the generated images
~$ docker images | grep latest
blewater/fabric-ca             latest                           1f5796cac18c        17 hours ago        177MB
hyperledger/fabric-ca          latest                           1f5796cac18c        17 hours ago        177MB
blewater/fabric-tools          latest                           f82fe2f8d301        17 hours ago        1.49GB
hyperledger/fabric-tools       latest                           f82fe2f8d301        17 hours ago        1.49GB
blewater/fabric-buildenv       latest                           1d0ccc3dfc1a        17 hours ago        1.43GB
hyperledger/fabric-buildenv    latest                           1d0ccc3dfc1a        17 hours ago        1.43GB
hyperledger/fabric-ccenv       latest                           968779ee5bb2        17 hours ago        1.4GB
blewater/fabric-ccenv          latest                           968779ee5bb2        17 hours ago        1.4GB
hyperledger/fabric-orderer     latest                           76e57fc8518c        17 hours ago        111MB
blewater/fabric-orderer        latest                           76e57fc8518c        17 hours ago        111MB
blewater/fabric-peer           latest                           9b02746c9cf4        18 hours ago        118MB
hyperledger/fabric-peer        latest                           9b02746c9cf4        18 hours ago        118MB
blewater/fabric-zookeeper      latest                           969207ec1a59        19 hours ago        497MB
hyperledger/fabric-zookeeper   latest                           969207ec1a59        19 hours ago        497MB
blewater/fabric-kafka          latest                           3819183d7baa        19 hours ago        491MB
hyperledger/fabric-kafka       latest                           3819183d7baa        19 hours ago        491MB
blewater/fabric-couchdb        latest                           16dd2c814964        19 hours ago        246MB
hyperledger/fabric-couchdb     latest                           16dd2c814964        19 hours ago        246MB
blewater/fabric-baseimage      latest                           fd1c6de7680f        19 hours ago        1.34GB
hyperledger/fabric-baseimage   latest                           fd1c6de7680f        19 hours ago        1.34GB
hyperledger/fabric-baseos      latest                           2954a8577995        22 hours ago        78.6MB
blewater/fabric-baseos         latest                           2954a8577995        22 hours ago        78.6MB

# You may now follow the docker hub instructions to push your images to your repo

# enjoy :)
```
