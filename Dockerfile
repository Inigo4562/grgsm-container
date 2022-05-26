FROM ubuntu:21.04

RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y python3 python-is-python3 wget unzip
RUN apt-get install -y gnuradio gnuradio-dev git cmake autoconf libtool pkg-config g++ gcc \
	make libc6 libc6-dev libcppunit-dev swig doxygen liblog4cpp5v5 liblog4cpp5-dev python3-scipy \
	gr-osmosdr libosmocore libosmocore-dev rtl-sdr osmo-sdr libosmosdr-dev libboost-all-dev \
	libgmp-dev liborc-dev libboost-regex-dev python3-docutils build-essential automake librtlsdr-dev \
	libfftw3-dev gqrx-sdr tshark gqrx-sdr cmake gnuradio libpython3-dev doxygen libosmocore \
	libgmp3-dev build-essential libtool libtalloc-dev libsctp-dev shtool autoconf automake \
	git-core pkg-config make gcc gnutls-dev libusb-1.0.0-dev libmnl-dev libpcsclite-dev \
	autoconf libtool pkg-config build-essential libcppunit-dev swig doxygen liblog4cpp5-dev \
	gnuradio-dev gr-osmosdr libosmogsm15 libosmocodec0 libosmogsm-doc libosmosdr0 libosmocodec-doc \
	libosmosdr-dev libosmocoding0 libosmocoding-doc libosmocore libosmocore16 libosmocore-dev \
	libosmocore-doc libosmocore-utils libosmoctrl0 libosmoctrl-doc librtlsdr-dev scapy pip gr-gsm

RUN wget http://nl.archive.ubuntu.com/ubuntu/pool/universe/c/cppunit/libcppunit-1.14-0_1.14.0-3_amd64.deb \
	&& dpkg -i libcppunit-1.14-0_1.14.0-3_amd64.deb && rm libcppunit-1.14-0_1.14.0-3_amd64.deb

RUN wget https://github.com/velichkov/gr-gsm/archive/refs/heads/maint-3.8.zip \
	&& unzip maint-3.8.zip && rm maint-3.8.zip

WORKDIR /gr-gsm-maint-3.8
RUN mkdir build
WORKDIR /gr-gsm-maint-3.8/build
RUN cmake .. && ldconfig

ENV PYTHONPATH=/usr/local/lib/python3/dist-packages/:$PYTHONPATH
RUN apt-get update

WORKDIR /

RUN wget https://github.com/steve-m/kalibrate-rtl/archive/refs/heads/master.zip \
	&& unzip master.zip && rm master.zip
WORKDIR /kalibrate-rtl-master
RUN ./bootstrap && CXXFLAGS='-W -Wall -O3' && ./configure && make && make install

WORKDIR /

# ----- RTL-sdr not working yet -----
# COPY ./rtl-sdr /rtl-sdr
# RUN mkdir /rtl-sdr/build
# WORKDIR /rtl-sdr/build
# RUN ./configure && make && make install

RUN wget https://github.com/Oros42/IMSI-catcher/archive/refs/heads/master.zip \
	&& unzip master.zip && rm master.zip

ENTRYPOINT [ "/bin/bash" ]
