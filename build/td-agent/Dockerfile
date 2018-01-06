FROM debian:stretch
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
	zlib1g \
	zlib1g-dev \
	libssl-dev \
	libyaml-dev \ 
	libxml2-dev \
	autoconf \
	libc6-dev \
	ncurses-dev \ 
	automake \
	libtool \
	rsync
RUN curl -L https://toolbelt.treasuredata.com/sh/install-debian-jessie-td-agent2.sh | /bin/sh
RUN apt-get install td-agent -y --allow-unauthenticated
# Работаем с локалями
RUN locale-gen ru_RU.UTF-8  
ENV LANG ru_RU.UTF-8  
ENV LANGUAGE ru_RU:en  
ENV LC_ALL ru_RU.UTF-8  


RUN rm /bin/sh && ln -s /bin/bash /bin/sh 
RUN echo "PATH=$PATH:/foo/bar" >> /root/.profile 
RUN echo "PATH=$PATH:/usr/local/lib/:/opt/drizzle/lib/:$LD_LIBRARY_PATH" >> ~/.bash_profile
RUN source ~/.profile
RUN /usr/sbin/td-agent-gem install fluent-plugin-elasticsearch
RUN /usr/sbin/td-agent-gem install fluent-plugin-ua-parser
RUN /usr/sbin/td-agent-gem install embulk-filter-woothee
RUN /usr/sbin/td-agent-gem install fast_woothee
RUN /usr/sbin/td-agent-gem install fluent-plugin-format
RUN /usr/sbin/td-agent-gem install fluent-plugin-woothee
RUN /usr/sbin/td-agent-gem install fluent-plugin-forest
RUN /usr/sbin/td-agent-gem install fluent-plugin-record-reformer

RUN echo $PATH
ADD run.sh /run.sh
  EXPOSE 24224 24225
  WORKDIR /
  ENTRYPOINT  /bin/bash /run.sh














