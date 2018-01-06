#!/bin/bash
export LD_LIBRARY_PATH=/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server:$LD_LIBRARY_PATH
/etc/init.d/td-agent  start;
#chown -R elasticsearch /elasticsearchlogs/
#chown -R elasticsearch /elasticsearchdata/
/etc/init.d/syslog-ng start;
/etc/init.d/kibana start;
/etc/init.d/ssh start;
#/usr/local/sbin/syslog-ng -Fvde
/bin/bash