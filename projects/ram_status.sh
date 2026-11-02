#!/bin/bash

FREE_SPACE=$(free -mt | grep "Total" | awk '{print $4}')

TH=6000

if [[ $FREE_SPACE -lt $TH ]]
then
	echo "RAM is low!!!"
else
	echo "RAM space is sufficient - $FREE_SPACE"
fi
