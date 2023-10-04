# declaring the os
FROM ubuntu:latest

# installing dependencies
RUN apt update \
&& apt install wget -y \
&& apt install build-essential -y \
&& apt install libnss-nis libnss-nisplus -y

# downloading subread package
RUN mkdir -p /opt/subread_package \ 
&& wget https://sourceforge.net/projects/subread/files/subread-2.0.6/subread-2.0.6-Linux-x86_64.tar.gz \
&& tar -xvf subread-2.0.6-Linux-x86_64.tar.gz -C /opt/subread_package --strip-components 1

# adding the bin folder to the path variable
ENV PATH /opt/subread_package/bin:$PATH
    
