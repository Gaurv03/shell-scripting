#!/bin/bash

#Generating random number from 1 to 6

NO=$(( $RANDOM%6 + 1  ))

echo "Number is $NO"
