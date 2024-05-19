# ce-linux
Build environment for CE Linux & script for using Mender API

## Building and running the Docker image 
To build the docker image, run:
```
docker build -t yoctobuild:v1 .
```
To run it as a container:
```
docker run -it yoctobuild:v1
```

## Setting the Yocto environment
Build can be started either from the Docker container (see above), or on a Linux distribution supported by the Yocto Project (see [system requirements](https://docs.yoctoproject.org/ref-manual/system-requirements.html))

**The instructions bellow are meant to be executed inside the Docker container.**
```
mkdir ce-linux
cd ce-linux
```
Make sure git user settings are set before starting: 
```
 git config --global user.name ""
 git config --global user.email ""
```
Initialize & sync repo
```
repo init -u https://github.com/janaperic/ce-linux.git -b main
repo sync
```
Bitbake settings
```
export TEMPLATECONF=${PWD}/layers/meta-ce/conf
. layers/poky/oe-init-build-env
cp ../layers/meta-ce/conf/local.conf.sample conf/local.conf
cp ../layers/meta-ce/conf/bblayers.conf.sample conf/bblayers.conf
```

## Build the image
```
bitbake ce-linux-image
```
## Flash image to SD card
Image will be stored in build/tmp/deploy/images/raspberrypi4-64/(image-name).sdimg
Flash it with bmaptool:
```
sudo bmaptool copy build/tmp/deploy/images/raspberrypi4-64/(image-name).sdimg /dev/mmcblk0
```
Bmaptool can be installed via the command (Ubuntu):
```
sudo apt install -y bmap-tools
```

***Alert:*** Flashing from the inside of the Docker container could be not possible, in that case, copy the image outside the container and flash it from the host. 

## Script for using the Mender API 
Bash script get-device-attr.sh can be used for gathering inventory information about the device from Mender server. 

Usage: 
```
./get-device-attr.sh (attribute)
```

Make sure script is executable. To make it executable, run: 
```
chmod +x get-device-attr.sh
```

