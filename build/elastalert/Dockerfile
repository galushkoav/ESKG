FROM ubuntu:16.04
LABEL maintainer="A.vgalushko86@gmail.com"
RUN apt-get update --fix-missing && apt-get install -y wget \
	curl \
	mc \
	sudo \
	locales \
    locales-all \
    ruby \
    build-essential \
	bison \
	openssl \
	git-core \
	python-pip \
	rsync

# Работаем с локалями
RUN locale-gen ru_RU.UTF-8  
ENV LANG ru_RU.UTF-8  
ENV LANGUAGE ru_RU:en  
ENV LC_ALL ru_RU.UTF-8  


RUN pip install elastalert
RUN pip install "elasticsearch>=5.0.0"
RUN echo $PATH
ADD run.sh /run.sh
  EXPOSE 3030
  WORKDIR /etc/elastalert/
  ENTRYPOINT  /bin/bash /run.sh














