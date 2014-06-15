#!/bin/bash

SCRIPTS="/home/owner/script/setupVM"
FILEPATH="/var/lib/libvirt/images/nfs-images/template.img"
MP="/mnt/kvm-disk"

while getopts h:i:o: OPT
do
  case $OPT in
    "h" ) FLG_H="TRUE" ; VALUE_H="$OPTARG" ;;
    "i" ) FLG_I="TRUE" ; VALUE_I="$OPTARG" ;;
    "o" ) FLG_O="TRUE" ; VALUE_O="$OPTARG" ;;
  esac
done

if [ "$FLG_H" = "" ]; then
  echo "Hostname must be set by the option: -h HOSTNAME"
  exit 1;
fi

if [ "$FLG_I" = "" ]; then
  echo "static IP Address must be set by the option: -i IPADDRESS"
  exit 1;
fi

if [ "$FLG_O" = "TRUE" ]; then
  echo '"-c"オプションが指定されました。 '
  echo "→値は$VALUE_Oです。"
fi


################################# setup start! ########################################

echo cp tmplate/template.img /var/lib/libvirt/images/nfs-images/"$VALUE_H".img
echo "Disk file copy completed."
"$SCRIPTS"/kvm-mount.sh /var/lib/libvirt/images/nfs-images/"$VALUE_H".img "$MP"
echo "Disk file mounted."
#設定ファイルの置換
sleep 1
cp "$SCRIPTS"/interfaces_temp "$SCRIPTS"/interfaces
 "$SCRIPTS"/replace_string.py "$SCRIPTS"/interfaces template "$VALUE_I"
#mv "$SCRIPTS"/interfaces "$MP"/etc/network/

echo "IP address changed."
sleep 1
cp "$SCRIPTS"/hosts_temp "$SCRIPTS"/hosts
 "$SCRIPTS"/replace_string.py "$SCRIPTS"/hosts template "$VALUE_H"
#mv "$SCRIPTS"/hosts "$MP"/etc/
sleep 1
echo "$VALUE_H" > "$MP"/etc/hostname
echo "Hostname changed."
"$SCRIPTS"/kvm-umount.sh "$MP"
echo "Disk file unmounted."
echo "setup completed!"
