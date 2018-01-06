FROM ubuntu:xenial
ENV PROMETHEUS_VERSION 2.0.0
ENV GO_VERSION 1.6
ENV GO_PATH /root/
ENV ALERTMANAGER_VERSION  0.12.0
ENV GRADLE_HOME=/opt/gradle/gradle-4.4
ENV LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:$LD_LIBRARY_PATH
ENV PATH=$PATH:$GRADLE_HOME/bin
ENV PATH=$PATH:$LD_LIBRARY_PATH
ENV GOPATH=$HOME/$GO_PATH
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

ENV COMPILE_DIR /build/
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
	curl \
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

RUN echo "GOPATH=$HOME/work" >> ~/.profile
RUN echo "PATH=$PATH:/usr/local/go/bin:$GOPATH/bin" >> ~/.profile

RUN /bin/bash -c "source ~/.profile"
RUN locale-gen ru_RU.UTF-8  
ENV LANG ru_RU.UTF-8  
ENV LANGUAGE ru_RU:en  
ENV LC_ALL ru_RU.UTF-8  

RUN mkdir -p $COMPILE_DIR 

RUN wget -P $COMPILE_DIR https://github.com/prometheus/prometheus/releases/download/v$PROMETHEUS_VERSION/prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz

RUN wget -P $COMPILE_DIR https://github.com/prometheus/alertmanager/releases/download/v$ALERTMANAGER_VERSION/alertmanager-$ALERTMANAGER_VERSION.linux-amd64.tar.gz

RUN cd $COMPILE_DIR && tar xzf prometheus-$PROMETHEUS_VERSION.linux-amd64.tar.gz
RUN cd $COMPILE_DIR && cp prometheus-$PROMETHEUS_VERSION.linux-amd64/prometheus /usr/local/bin/
RUN cd $COMPILE_DIR && cp prometheus-$PROMETHEUS_VERSION.linux-amd64/promtool /usr/local/bin/

RUN cd $COMPILE_DIR && tar xzf alertmanager-$ALERTMANAGER_VERSION.linux-amd64.tar.gz
RUN cd $COMPILE_DIR && cp alertmanager-$ALERTMANAGER_VERSION.linux-amd64/alertmanager /usr/local/bin/
RUN cd $COMPILE_DIR && cp alertmanager-$ALERTMANAGER_VERSION.linux-amd64/amtool /usr/local/bin/

RUN cd $GO_PATH && wget https://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz && tar xvf go$GO_VERSION.linux-amd64.tar.gz && mv go /usr/local




RUN go get github.com/gin-gonic/gin && go get github.com/go-telegram-bot-api/telegram-bot-api
RUN git clone https://github.com/inCaller/prometheus_bot.git $COMPILE_DIR/prometheus_bot
RUN cd $COMPILE_DIR/prometheus_bot && make clean && make && cp prometheus_bot /usr/local/bin/


COPY init.d/prometheus /etc/init.d/
COPY init.d/alertmanager /etc/init.d/
COPY init.d/prometheus_bot /etc/init.d/

RUN chmod +x /etc/init.d/prometheus && systemctl unmask prometheus
RUN chmod +x /etc/init.d/alertmanager && systemctl unmask alertmanager
RUN chmod +x /etc/init.d/prometheus_bot && systemctl unmask prometheus_bot

ADD run.sh /run.sh
  EXPOSE 9090 9093 8097
  WORKDIR /
  ENTRYPOINT  /bin/bash /run.sh
