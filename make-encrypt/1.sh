#!/bin/bash

sudo dd if=/dev/urandom of=/dev/sdb bs=512 seek=4 count=16 ## /dev/sdb is the USB drive
sudo dd if=/dev/sdb of=~/usb_secret.key bs=512 skip=4 count=16 ## 마찬가지로 확인
xxd ~/usb_secret.key


blkid # 여기서 crypto device 확인