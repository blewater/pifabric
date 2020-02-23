# Hyperledger Fabric Chaincode for 64-bit Raspberry-Pi4 and Pi3
Batteries included: utilize the prepared Fabric [Docker Images](https://hub.docker.com/r/blewater).

If you would rather build the Docker images yourself, I have you got you covered with a Fabric v1.4.4 Docker Images building guide for Ubuntu 19.10.

Sample temperature and humidity sensor readings with a Fabric smart contract on latest high performing Linux 64-bit arm64v8 kernel 5.3.0-1018-raspi2 aarch64 on Ubuntu 19.10

## Getting Started

You need the following gadgets:

* A Raspberry Pi4. Edition with 4Gig Ram. 
* A kit or separatedly case and power adaptor. 
* A breadboard
* 10+ [dupont wire 20cm male to female](https://www.amazon.com/EDGELEC-Breadboard-Optional-Assorted-Multicolored/dp/B07GD1XFWV/ref=sr_1_3?keywords=dupont+wire+20cm+male+to+female&qid=1582390213&sr=8-3)
* An HDMI monitor
* A plain keyboard, wireless preferred with mice included e.g. [Logitech](https://www.amazon.com/Logitech-920-004090-Wireless-Keyboard-K360/dp/B00822GICW/ref=pd_sbs_147_img_2/142-3858854-6761000?_encoding=UTF8&pd_rd_i=B00822GICW&pd_rd_r=c2c5a593-dd7d-49bc-824f-1c25a154702c&pd_rd_w=KqxJf&pd_rd_wg=6ABHf&pf_rd_p=5cfcfe89-300f-47d2-b1ad-a4e27203a02a&pf_rd_r=QC900D6VD4323GA75PH5&psc=1&refRID=QC900D6VD4323GA75PH5). Later you may utilize ssh.
* A standard ethernet cable. You may also utilize the embedded wifi adapter with great results in Ubuntu.
A high performing [SD card with at least 32Gig](https://www.amazon.com/SanDisk-64GB-Extreme-UHS-I-SDSDXXY-064G-GN4IN/dp/B07H9J1YXN/ref=sr_1_3?crid=3T9H0M95H6N0B&keywords=sd+card+64gb&qid=1582390672&sprefix=sd+card%2Caps%2C308&sr=8-3).


Follow the instructions to [install \*64bit Ubuntu 19.10.](https://ubuntu.com/download/raspberry-pi/thank-you?version=19.10.1&architecture=arm64+raspi3)
*Please note Hyperledger Fabric requires 64bit OS which excludes the Raspbian OS.

Login to Ubuntu:

  user: ubuntu
  
  pwd: ubuntu
*You will be forced to change your password* :)

### Software updates (when applicable we will use snap to speed up lthe installation process)
* Ubuntu updates
Refer to answers https://askubuntu.com/questions/196768/how-to-install-updates-via-command-line

* sudo reboot

* login

* run uname -a

*(at the time of this writeup the latest Linux ARM kernel is 5.3.0-1018-raspi2)*

* Optionally, you may follow a Ubuntu guide to set a statip IP address and SSH access by public key. 

Refer to /etc/netplan apply, ssh-copy-id
  
* Install **docker** Run these commands:
```
sudo snap install docker

sudo groupadd docker

sudo usermod -aG docker ${USER}

logout

login

docker run hello-world 
# should download and run the hello-world image without requiring sudo access

docker-compose version
# displays version 1.23.2+
```
* install go language compiler/linker binaries
```
sudo snap install --channel=1.11/stable go --classic
nano ~/.bashrc
# add the following last line
export GOPATH=~/go
# save & exit
source ~/.bashrc
mkdir -p ~/go

cd pifabric
```







