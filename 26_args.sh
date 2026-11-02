#!/bin/bash

set -x # will show steps if execution for debugging

#to access the args

if [[ $# -eq 0 ]]
then
	echo "No argument is provided"
	exit 1
fi

echo "First argument $1"
echo "Second argument $2"

echo "All the arguments are - $@"
echo "Number of arguments are - $#"

# for loop to access the values from args
for filename in $@
do
	echo "Copying file - $filename"
done
