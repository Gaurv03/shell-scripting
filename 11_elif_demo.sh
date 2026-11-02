#!/bin/bash

read -p "Enter your marks: " usr_marks

if [[ $usr_marks -ge 80 ]]
then
	echo "!st division"
elif [[ $usr_marks -ge 60 ]]
then
	echo "2nd division"
elif [[ $usr_marks -ge 40 ]]
then
	echo "3rd division"
else
	echo "You are fail"
fi
