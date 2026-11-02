#!/bin/bash

#monitoring the free fs disk space 

FU=$(df -H | egrep -v 'Filesystem|tmpfs' | grep 'nvme0n1p2' | awk '{print $5}' | tr -d %)
TO="your-email@email.com"

if [[ $FU -ge 10 ]]
then
	echo "Warning disk space is low - $FU %" | mail -s "Disk SPACE ALERT" $TO
else
	echo "All good"
fi

