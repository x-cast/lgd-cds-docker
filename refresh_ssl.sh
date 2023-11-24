#!/bin/bash
cd /data/lgd-cds-docker
source .env
mkdir ssl
curl -L "${CMS}/get/ssl/chain/${LOCAL_IP}" > "./ssl/chain.pem";
curl -L "${CMS}/get/ssl/key/${LOCAL_IP}" > "./ssl/key.pem";
curl -L "${CMS}/get/ssl/ssl/${LOCAL_IP}" > "./ssl/ssl.pass";

docker exec -i nginx /bin/bash -c "nginx -s reload"