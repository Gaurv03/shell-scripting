#1/bin/bash

FILEPATH="/home/usrname/Desktop/Linux/test.txt"
if [[ ! -f $FILEPATH ]]
then
	echo "File exists"
else
	echo "File not exists"
	exit 1
fi
	
