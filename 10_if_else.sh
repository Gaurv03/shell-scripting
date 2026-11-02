#!/bin/bash

read -p "Enter your marks: " usr_marks

if [[ $usr_marks -gt 40 ]]
then
	echo "You are pass"
else
	echo "You are fail"
fi
