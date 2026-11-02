#!/bin/bash

echo "Provide an option"
echo "a for print date"
echo "b for list of script"
echo "c to check the current location"

read choice

case $choice in
	a)
		echo "Today's date is"
		date
		echo "Ending...."
		;;
	b)ls -ltr;;
	c)pwd;;
	*)echo "Please provide a valid option"
esac
