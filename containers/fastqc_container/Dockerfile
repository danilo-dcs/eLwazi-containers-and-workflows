#Using official ubuntu image as a parent image
FROM ubuntu:latest

# Install Dependencies
RUN apt-get update && \
apt-get install -y unzip \
    	build-essential \
    	wget \
    	debconf-utils \
    	software-properties-common \
&& apt-add-repository ppa:openjdk-r/ppa \
&& apt-get install -y openjdk-8-jre \
&& rm -rf /var/lib/apt/lists/*

# Download FastQC
RUN cd /opt \
    	&& wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.8.zip \
    	&& unzip fastqc_v0.11.8.zip \
    	&& chmod 755 FastQC/fastqc \
    	&& rm /opt/fastqc_v0.11.8.zip

#Add the tool directory to env variable
ENV PATH=/opt/FastQC:$PATH

