FROM ubuntu:20.04
CMD bash

# Install Ubuntu packages.
# Please add packages in alphabetical order.
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update 
RUN apt-get -y install sudo
COPY script/installation/packages.sh install-script.sh 
RUN echo y | ./install-script.sh all

COPY . /repo

WORKDIR /repo

RUN mkdir build
RUN cd build
RUN cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DNOISEPAGE_USE_JEMALLOC=ON -DNOISEPAGE_UNITY_BUILD=ON ..
RUN ninja noisepage
RUN ./bin/noisepage
