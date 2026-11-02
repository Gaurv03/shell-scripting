#!/bin/bash

myVar="Hey Vinter, How are you?"

myVarLength=${#myVar}

echo "Length of myVar is $myVarLength"

echo "To upper case is ----- ${myVar^^}"
echo "To lower case is ----- ${myVar,,}"

#replace a string
newVar=${myVar/Vinter/usrname}
echo "New var is ----- ${newVar}"

#slice string

echo "Sliced ste ----- ${myVar:4:6}"
