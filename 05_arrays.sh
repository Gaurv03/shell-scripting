#!/bin/bash

# Arrays

myArray=(1 2 Hello   "Hey Vinter")

echo "All the values in array are ${myArray[*]}"
echo ${myArray[0]}
echo ${myArray[3]}

# Array length
echo "Length of array is ${#myArray[*]}"

echo "Valuea from index 2-3 ${myArray[*]:2:2}"

#Updating array elements

myArray+=(30 14 85)

echo "New length of array is ${#myArray[*]}"
