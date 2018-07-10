# cross-compile-using-docker

Cross compile c/cpp source code in a docker container.

## 1. Write a build script crossbuild.sh to simply call make

```crossbuild.sh``` file

    #!/bin/sh
    cd /source/examples && make CROSS=arm-openwrt-linux-uclibcgnueabi- TARGET_FOLDER=openwrt

## 2. Build an image with the proper cross compile toolchain

* Edit ```Dockerfile``` file content

        FROM pyro225/ubuntu-32bit
        # install make
        RUN apt-get update && apt-get install -y make
        # copy cross compile toolchain
        COPY ./toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi /toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi
        # copy helper script
        COPY ./crossbuild.sh /crossbuild.sh
        # set path for cross compile toolchain
        ENV PATH $PATH:/toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi/bin

* Build the image ```crossbuild```
    
        docker build -t crossbuild  .

* Tag the image and push it to docker hub, so that it can be shared with teams
    
        docker tag crossbuild duhj/crossbuild:latest
        docker push duhj/crossbuild

## 3. Cross compile source code

    docker run  -v /path/to/source:/source crossbuild /bin/sh crossbuild.sh
