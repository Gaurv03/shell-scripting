#!/bin/bash

#Script to show how to use variables

a=10
name="Vinter"
age=28

echo "My name is $name and age is $age"

name="Blade"

echo "My name is $name"

#Varible to store the output of a command

HOSTNAME=$(hostname)
echo "Name of this machine is $HOSTNAME"
