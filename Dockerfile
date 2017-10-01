FROM ubuntu:16.04

RUN apt-get update && apt-get install -y git cmake make wget curl tar bzip2 \
	python python-dev python-pip \
	&& rm -rf /var/lib/apt/lists/*

# download MITIE
RUN cd /; git clone https://github.com/mit-nlp/MITIE.git

# download MITIE models
RUN cd /MITIE; make MITIE-models

# build MITIE executables and libs
RUN cd /MITIE; make

# build Shared libraries
RUN cd /MITIE/mitielib \
	&& mkdir build \
	&& cd build \
	&& cmake .. \
	&& cmake --build . --config Release --target install
