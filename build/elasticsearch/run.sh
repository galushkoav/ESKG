#!/bin/bash
chmod 777 -R /etc/elasticsearch;
mkdir -p  /elasticlogs;
mkdir -p  /elasticdata;

	for path in \
		/usr/share/elasticsearch/data \
		/usr/share/elasticsearch/logs \
		/elasticlogs \
		/elasticdata \
	; do
		chown -R elasticsearch:elasticsearch "$path"
	done

/etc/init.d/elasticsearch start;
/bin/bash