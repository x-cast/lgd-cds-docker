#!/bin/bash
### .env 파일은 수동으로 작성해 주세요 
cd /data/lgd-cds-docker
source .env
docker-compose down
docker rmi kip9696/lgd-cds-node:latest

curl -L "${CMS}/get/ssl/chain/${LOCAL_IP}" > "./ssl/chain.pem";
curl -L "${CMS}/get/ssl/key/${LOCAL_IP}" > "./ssl/key.pem";
curl -L "${CMS}/get/ssl/ssl/${LOCAL_IP}" > "./ssl/ssl.pass";

docker-compose up -d