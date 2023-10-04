# Use an official Debian-based image as the base image

FROM debian:buster

# Set environment variables (optional)

ENV SAMTOOLS_VERSION=1.13

# Update package lists and install required dependencies

RUN apt-get update && \
apt-get install -y \
build-essential \
wget \
zlib1g-dev \
liblzma-dev \
libbz2-dev \
libcurl4-openssl-dev \
libncurses5-dev

# Download and compile Samtools

WORKDIR /tmp

RUN wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
tar -xjf samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
cd samtools-${SAMTOOLS_VERSION} && \
make && \
make install

# Clean up – remove unecessary tools to reduce image size

RUN rm -rf /tmp/samtools-${SAMTOOLS_VERSION} && \
apt-get remove -y build-essential wget && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/*

# Set the working directory for your container

WORKDIR /data

# Define the command to run when the container starts

CMD ["samtools"]
