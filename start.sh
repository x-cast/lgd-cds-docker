#!/bin/bash
### .env 파일은 수동으로 작성해 주세요 
cd /data/lgd-cds-docker
source .env
mkdir ssl
mkdir logs
mkdir cache

curl -L "${CMS}/get/ssl/chain/${LOCAL_IP}" > "./ssl/chain.pem";
curl -L "${CMS}/get/ssl/key/${LOCAL_IP}" > "./ssl/key.pem";
curl -L "${CMS}/get/ssl/ssl/${LOCAL_IP}" > "./ssl/ssl.pass";

if [ -s "./ssl/chain.pem" ]; then
    cp ./conf/vod-cds.conf ./vod-cds.conf
else 
    cp ./conf/vod-cds-notls.conf ./vod-cds.conf
fi


docker-compose up -d