# cross-compile-using-docker

Cross compile c/cpp source code in a docker container

## 1. Write a wrapper build script ```crossbuild.sh``` that simply invokes makefile

    #!/bin/sh
    cd /source/examples && make CROSS=arm-openwrt-linux-uclibcgnueabi- TARGET_FOLDER=openwrt

## 2. Build an docker image with the proper cross compile toolchain added

* Create ```Dockerfile``` file, with content as below:

        FROM pyro225/ubuntu-32bit
        # install make
        RUN apt-get update && apt-get install -y make
        # install cross compile toolchain
        COPY ./toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi /toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi
        # install wrapper build script
        COPY ./crossbuild.sh /crossbuild.sh
        # set path for cross compile toolchain
        ENV PATH $PATH:/toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi/bin

* Build the docker image
        
        cd /path/to/Dockerfile
        docker build -t crossbuild  .

* Tag the docker image and push it to docker hub, so that it can be shared with others
    
        docker tag crossbuild duhj/crossbuild:latest
        docker push duhj/crossbuild

## 3. Cross compile source code

    docker run  -v /path/to/source:/source duhj/crossbuild /bin/sh crossbuild.sh
