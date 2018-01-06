FROM ubuntu:xenial
ENV LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:$LD_LIBRARY_PATH
ENV PATH=$PATH:$LD_LIBRARY_PATH

RUN apt-get update --fix-missing && apt-get install -y wget \
	curl \
	mc \
	sudo \
	locales \
    locales-all \
	tzdata \
	rsync \
	apt-transport-https \
	wget \
	nano \
	gnupg
RUN locale-gen ru_RU.UTF-8  
ENV LANG ru_RU.UTF-8  
ENV LANGUAGE ru_RU:en  
ENV LC_ALL ru_RU.UTF-8  


RUN apt-get update && apt-get install -y openjdk-8-jdk
RUN echo "LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:$LD_LIBRARY_PATH" >> /etc/default/syslog-ng

RUN wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.6.3.deb && dpkg -i elasticsearch-5.6.3.deb
ADD run.sh /run.sh
  EXPOSE 9200 9300
  WORKDIR /
  ENTRYPOINT  /bin/bash /run.sh
