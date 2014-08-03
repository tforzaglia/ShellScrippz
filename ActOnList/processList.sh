#!/bin/bash

#simple script to act on a list of files or directories

#ask for the name of the input file
echo "Enter the name of the input file"
read file

#ask for the command to run
echo "Enter the command you want to run on the input file"
read command

#redirect the input file to stdin
exec<$file

#read line by line
while read line
	do
		#execute the user input command on the line
		$command $line
	done
