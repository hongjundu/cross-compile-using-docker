FROM pyro225/ubuntu-32bit
RUN apt-get update && apt-get install -y make
COPY ./toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi /toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi
COPY ./crossbuild.sh /crossbuild.sh
ENV PATH $PATH:/toolchain-arm_v7-a_gcc-4.6-linaro_uClibc-0.9.33.2_eabi/bin