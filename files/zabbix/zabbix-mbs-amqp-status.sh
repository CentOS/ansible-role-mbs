#!/bin/bash
# Called by Zabbix to check if we have error message in fedmsg-hub about ubm/amqp connection error

PATH=$PATH:/usr/local/bin:/sbin:/usr/sbin/


journalctl --no-pager --since="1 hour ago" -u fedmsg-hub |grep -E 'twisted.internet.error.ConnectionLost|twisted.internet.error.ConnectionRefusedError|twisted.internet.error.TimeoutError'

zabbix_sender -c /etc/zabbix/zabbix_agentd.conf -k amqp.connection.status -o "$?" 2>&1 >/dev/null

