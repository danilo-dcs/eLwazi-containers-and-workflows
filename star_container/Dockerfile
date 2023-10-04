FROM debian:stable-slim

MAINTAINER mohanadadam32@gmail.com, assekagiri@gmail.com

ARG STAR_VERSION=2.7.11a

ENV PACKAGES gcc g++ make wget zlib1g-dev unzip libgomp1

RUN set -ex

RUN cd /opt \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends ${PACKAGES} \
	&& apt-get clean  \
	&& g++ --version \
	&& wget --no-check-certificate https://github.com/alexdobin/STAR/releases/download/2.7.11a/STAR_2.7.11a.zip \
	&& unzip STAR_2.7.11a.zip

ENV PATH /opt/STAR_2.7.11a/Linux_x86_64:${PATH}

