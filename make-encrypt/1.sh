## u must excute on root permission [ sudo su ] ##
sudo apt install dosfstools -y
mkdir /media/usb
mount /dev/${USBPARTITION} /media/usb ## ex) /dev/sda1
dd if=/dev/urandom of=/media/usb/key bs=2048 count=4
cryptsetup luksAddKey /dev/${NOCRYPTDEVICE} /media/usb/key
umount /media/usb
fatlabel /dev/${USBPARTITION} USBKEY
fatlabel /dev/${USBPARTITION} USBKEY

## manual !! 
## vi /etc/crypttab
## cryptroot UUID=452ac6ac-8bbb-484f-b508-a11a5585e031 none luks <<< 
## >>>> cryptroot UUID=452ac6ac-8bbb-484f-b508-a11a5585e031 /dev/disk/by-label/USBKEY:/key:20 luks,keyscript=/lib/cryptsetup/scripts/passdev
## update-initramfs -k all -u

