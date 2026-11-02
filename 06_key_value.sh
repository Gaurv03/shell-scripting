#!/bin/bash

# how to store in key-value pair

declare -A myArray

myArray=( [name]=Vinter [age]=28 [city]=Washington )

echo "Name is ${myArray[name]}"
echo "Age is ${myArray[age]}"
