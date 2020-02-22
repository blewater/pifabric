# Optional Building the Hyperledger Fabric Images for 64-bit ARM devices
Please note these images are already available at [Docker Images](https://hub.docker.com/r/blewater).

For the general Fabric setup guide for RaspberryPi4 is [here](README.md)

## Getting Started

* clone the Fabric code base
```
mkdir -p ~/go/src/github.com/hyperledger/

cd ~/go/src/github.com/hyperledger/

git clone https://github.com/hyperledger/fabric
git clone https://github.com/hyperledger/fabric-samples
git clone https://github.com/hyperledger/fabric-baseimage
git clone https://github.com/hyperledger/fabric-chaincode-go

```

## Building the base images (couchdb, kakfa, zookeeper)

```
git clone https://github.com/blewater/pifabric
cp -r ./pifabric/baseimage/* ./fabric-baseimage/

sudo apt install make

cd fabric-baseimage

make all
```






