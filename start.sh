#!/bin/bash

/opt/acestream/acestream.start >/dev/null 2>&1 &

/usr/bin/python2.7 /opt/HTTPAceProxy-master/acehttp.py >/dev/null 2>&1 &

/opt/TorrServer/TorrServer-linux-amd64 >/dev/null 2>&1 &

while true; do
        sleep $1
        rm -rf /tmp/state/.ACEStream/.acestream_cache/* /tmp/state/.ACEStream/collected_torrent_files/*
done
