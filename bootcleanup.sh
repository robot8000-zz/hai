#!/bin/bash

echo "===================================================================="
echo "This script will copy all important files from the /boot partition"
echo "and compress it into an archive where it will be safe while we clean"
echo "and when we are done cleaning, we can decompress the archive back to"
echo "the freshly cleaned /boot partition."
sleep 5

# Making an archive of the kernel and other important boot files
echo "===================================================================="
echo "We are tarring up and compressing the kernel and boot dependencies."
echo "===================================================================="
sleep 5
tar zcvf ~/bootfiles.tar.gz /boot/config-$(uname -r) /boot/grub /boot/grub2 \
/boot/initramfs*rescue*.img /boot/initramfs-$(uname -r).img \
/boot/initramfs-$(uname -r)kdump.img /boot/initrd-plymouth.img \
/boot/symvers-$(uname -r).gz /boot/System.map-$(uname -r) \
/boot/vmlinuz*rescue* /boot/vmlinuz-$(uname -r) \
/boot/.vmlinuz-$(uname -r).hmac
wait
sleep 5

# Created archive, stored in /root, cleaning /boot partition completely 
echo "===================================================================="
echo "Now we are cleaning out the /boot partition of all the junk that"
echo "we no longer need."
echo "===================================================================="
sleep 5
rm -rf /boot/*
wait
sleep 5

# Extraction of the files from the archive back to /boot partition
echo "Lastly, we are replacing the important files that we took from the"
echo "/boot partition with this script for safety during cleaning."
echo "===================================================================="
sleep 5
tar -zxvf ~/bootfiles.tar.gz -C /
wait
sleep 5

# Script finished
echo "===================================================================="
echo "The script is now finished running and only the important kernel"
echo "and boot files remain. You should now be able to successfully install"
echo "the firmware upgrade file without errors. You may now close the CLI"
echo "window."
echo "===================================================================="
