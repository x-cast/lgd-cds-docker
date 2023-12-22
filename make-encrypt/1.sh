## u must excute on root permission [ sudo su ] ##

dd if=/dev/urandom of=${MOUNTDEVICE}/key bs=2048 count=4
cryptsetup luksAddKey /dev/${NOCRYPTDEVICE} ${MOUNTDEVICE}/key
fatlabel /dev/${USBDEVICE} USBKEY
## if mount usb device, u have to umount device

## manual !! 
## vi /etc/crypttab
## cryptroot UUID=452ac6ac-8bbb-484f-b508-a11a5585e031 none luks <<< 
## >>>> cryptroot UUID=452ac6ac-8bbb-484f-b508-a11a5585e031 /dev/disk/by-label/USBKEY:/key:20 luks,keyscript=/lib/cryptsetup/scripts/passdev
## update-initramfs -k all -u

