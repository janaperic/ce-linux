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
