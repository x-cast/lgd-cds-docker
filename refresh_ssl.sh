#!/bin/sh
### .env 파일은 수동으로 작성해 주세요 ===> env파일도 다운받아서..?
### cds 내에 network[eth ip는 현재 docker ip로 잡히므로 해당 부분 해결]
cd /data/lgd-cds-docker
source .env

curl -L "${CMS}/get/ssl/chain/${LOCAL_IP}" > "./ssl/chain.pem";
curl -L "${CMS}/get/ssl/key/${LOCAL_IP}" > "./ssl/key.pem";

docker exec -it nginx /bin/bash -c "nginx -s reload"