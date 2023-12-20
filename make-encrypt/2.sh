#!/bin/bash

cryptsetup luksAddKey ${NOCRYPT디바이스} ~/usb_secret.key --key-slot 1 # /dev/sda3 ==> 1번에서 blkid 를 통해 확인한 crypt device
## 암호 입력

ln ${USB} /dev/usbdevice # /dev/sdb ==> 1번에서 확인한 USB device
echo 'SUBSYSTEMS=="usb", DRIVERS=="usb", SYMLINK+="usbdevice%n"' > /etc/udev/rules.d/99-custom-usb.rules
udevadm control --reload-rules

echo '#!/bin/sh
TRUE=0
FALSE=1

# flag tracking usb availability
OPENED=$FALSE

sleep 2

if [ -b /dev/usbdevice ]; then
# if device exists then output the keyfile from the usb 
dd if=/dev/usbdevice bs=512 skip=4 count=16 | cat
OPENED=$TRUE
fi

if [ $OPENED -ne $TRUE ]; then
echo "Failed using usb as key." >&2
/lib/cryptsetup/askpass "Try using LUKS passphrase: "
else
echo "Successfully used usb as key." >&2
fi

sleep 2
' > /usr/local/sbin/openluksdevices.sh
chmod a+x /usr/local/sbin/openluksdevices.sh

echo -n ',keyscript=/usr/local/sbin/openluksdevices.sh' >> /etc/crypttab ##이부분 들어가서 줄바꿈 위로 올리기

echo CRYPTROOT=target=${CRYPT디바이스},source=/dev/disk/by-uuid/${NOCRYPT디바이스UUID} > /etc/initramfs-tools/conf.d/cryptroot #taget 확인하고, UUID 수정하자 
echo '#!/bin/sh
PREREQ="udev"
prereqs()
{
echo "$PREREQ"
}

case $1 in
prereqs)
prereqs
exit 0
;;
esac

. /usr/share/initramfs-tools/hook-functions

# copy across relevant rules
cp /etc/udev/rules.d/99-custom-usb.rules ${DESTDIR}/lib/udev/rules.d/

exit 0
' > /etc/initramfs-tools/hooks/udevusbkey.sh
chmod a+x /etc/initramfs-tools/hooks/udevusbkey.sh

echo 'You Must Remove Newline in /etc/crypttab!!!!'
echo 'You Must Remove Newline in /etc/crypttab!!!!'
echo 'You Must Remove Newline in /etc/crypttab!!!!'