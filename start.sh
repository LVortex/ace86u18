#!/bin/bash

/acestream.engine/acestream.start >/dev/null 2>&1 &

/opt/HTTPAceProxy-master/acehttp.py >/dev/null 2>&1 &

while true; do
        sleep $2
        rm -rf /tmp/state/.ACEStream/.acestream_cache/* /tmp/state/.ACEStream/collected_torrent_files/*
done