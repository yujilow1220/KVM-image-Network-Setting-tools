#!/bin/bash
#引数: 仮想ディスクのパス
DISK=$1
losetup /dev/loop0 $DISK
kpartx -a /dev/loop0
mount /dev/mapper/loop0p1 /mnt/kvm-disk
