# ce-linux
Build environment for CE Linux

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

