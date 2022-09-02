FROM ubuntu:20.04
RUN apt-get update \
    && apt-get install -y wget \
    && apt install unzip \
    && apt-get install -y bsdmainutils \
    && rm -rf /var/lib/apt/lists/*
RUN wget --content-disposition https://ngc.nvidia.com/downloads/ngccli_linux.zip && unzip ngccli_linux.zip && chmod u+x ngc-cli/ngc
RUN mkdir /root/.ngc
COPY config /root/.ngc
RUN ln -s $(pwd)/ngc-cli/ngc /usr/local/bin/ngc
COPY upload-dataset.sh .
RUN chmod +x upload-dataset.sh 
