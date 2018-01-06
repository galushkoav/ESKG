#!/bin/bash
rm /prometheusdata/lock
/etc/init.d/alertmanager start;
/etc/init.d/prometheus_bot start;
/usr/local/bin/prometheus --config.file="/etc/prometheus/prometheus.yml" --storage.tsdb.path="/prometheusdata/" --storage.tsdb.retention=30d --alertmanager.notification-queue-capacity=200 --alertmanager.timeout=10s  --log.level=info 
/bin/bash