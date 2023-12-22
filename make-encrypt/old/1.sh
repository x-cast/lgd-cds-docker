#!/bin/bash

## 모든 명령어는 sudo su를 친상태에서 실행 [root 권한으로]
## lsblk 입력해서 usb name 확인하자  ##

sudo dd if=/dev/urandom of=${USB} bs=512 seek=4 count=16 ## /dev/sdb is the USB drive
sudo dd if=${USB} of=~/usb_secret.key bs=512 skip=4 count=16 ## 마찬가지로 확인
xxd ~/usb_secret.key

blkid # 여기서 crypto device 확인