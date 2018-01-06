#!/bin/bash
/usr/bin/find /var/log/  -name "*.gz" -type f  | xargs /bin/rm  -rf
/usr/bin/find /var/log/  -name "*.log.*" -type f  | xargs /bin/rm  -rf
/usr/bin/find /var/log/  -name "*.1" -type f | xargs /bin/rm  -rf
 find /var/log/elasticsearch/* -type f -ctime +2 | xargs rm -rf
echo "Переинициализация логов nginx"

[ ! -f /var/run/nginx.pid ] || /bin/kill -USR1 `/bin/cat /var/run/nginx.pid`

/usr/sbin/logrotate /etc/logrotate.conf > /dev/null 2>&1


