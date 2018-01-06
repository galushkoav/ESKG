FROM ubuntu:xenial
ENV GRADLE_HOME=/opt/gradle/gradle-4.4
ENV LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:$LD_LIBRARY_PATH
ENV PATH=$PATH:$GRADLE_HOME/bin
ENV PATH=$PATH:$LD_LIBRARY_PATH

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
	tzdata \
	libc6-dev \
	ncurses-dev \
	automake \
	libtool \
	rsync \
	apt-transport-https \
	software-properties-common \
	wget \
	libdbd-pgsql \
	python-pip \
	nano \
	gnupg
RUN locale-gen ru_RU.UTF-8  
ENV LANG ru_RU.UTF-8  
ENV LANGUAGE ru_RU:en  
ENV LC_ALL ru_RU.UTF-8  



RUN apt-get update && apt-get install -y openjdk-8-jdk
RUN echo "LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:$LD_LIBRARY_PATH" >> /etc/default/syslog-ng


RUN mkdir -p /root/src && mkdir -p /opt/gradle
RUN apt-get install -y bison gcc+ libglib2.0-0 gettext libgettextpo-dev autopoint flex libpcre3 glib-2.0 libglib2.0-dev  libriemann-client-dev riemann-c-client libhiredis-dev libesmtp-dev libnet-dev libmaxminddb-dev libgeoip-dev libdbi-dev autoconf-archive 
RUN cd /root/src && wget https://services.gradle.org/distributions/gradle-4.4-bin.zip && unzip -d /opt/gradle gradle-4.4-bin.zip

RUN cd /root/src  && git clone https://github.com/balabit/syslog-ng/

RUN cd /root/src/syslog-ng && pip install -r requirements.txt
RUN cd /root/src/syslog-ng && ./autogen.sh
RUN /bin/bash -c "source /root/.profile"
RUN cd /root/src/syslog-ng && ./configure --enable-all-modules --enable-systemd
RUN cd /root/src/syslog-ng make -j4 && make install  

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" >> /etc/apt/sources.list.d/elastic-5.x.list
RUN apt-get update &&  apt-get install kibana -y

RUN /bin/bash -c "source ~/.profile"
RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent2.sh | /bin/sh

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
ADD run.sh /run.sh
ADD init.d/syslog-ng /etc/init.d/syslog-ng
RUN chmod +x /etc/init.d/syslog-ng && systemctl unmask syslog-ng
RUN apt-add-repository ppa:ansible/ansible
RUN apt-get update && apt-get install ansible openssh-server -y

  EXPOSE 24224 24225
  WORKDIR /
  ENTRYPOINT  /bin/bash /run.sh
