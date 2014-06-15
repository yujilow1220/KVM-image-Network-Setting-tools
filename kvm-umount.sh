#!/bin/bash
#引数: マウントポイント
MOUNTPATH=$1
umount $MOUNTPATH
kpartx -d /dev/loop0
losetup -d /dev/loop0
