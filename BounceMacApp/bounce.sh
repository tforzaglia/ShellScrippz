#!/bin/bash

#shell script to bounce an app provided as a command line argument
#if the provided app is not running, you are given the option to start it

#check to see if the command line argument is provided
if [ $# == 0 ]; then
    
    #if not, print the instructions for running the script with an example
    echo "Enter the name of the app you want to bounce as an argument on the command line."
    echo "Example: ./bounce.sh Mail"

#app was provided on the command line
else

    #app variable is set to the command line
    app=$1;

    #find the PID
    pid=`ps -ef | grep -i $app | grep -v grep | grep -v bounce.sh | awk '! /0:00.00/ {print $2 ;}'`

    #test if the length of the PID string is empty
    if [[ -z $pid ]]; then

        #PID is empty meaning the provided app is not running. Ask if the user wants to start the app
        echo "$app is not currently running. Would you like to start it [y/n]?"

        #read in the user input
        read choice

        #if the user enters 'y', start the app
        if [ $choice == 'y' ]; then
            open -a /Applications/$app.app

	    #get and report the new PID of the app
            pid=`ps -ef | grep -i $app | grep -v grep | grep -v bounce.sh | awk '! /0:00.00/ {print $2 ;}'`
            echo "$app is now running under PID $pid"
        
        #if the user enters anything else, terminate execution of the script
        else
            echo "Bye"
        fi    
        
    #PID is not empty and the process is running
    else

        #Print out the PID of the application
        echo "$app is running under $pid"

	echo "Are you sure you want to restart $app [y/n]?"

	#read in the user input
        read choice

        #if the user enters 'y', start the app
        if [ $choice == 'y' ]; then

        	#kill the application
        	kill -3 $pid >/dev/null 2>/dev/null

        	#sleep for 5 seconds
        	sleep  5

        	#start the app back up
        	open -a /Applications/$app.app/

		#get and report the new PID of the app
    		pid=`ps -ef | grep -i $app | grep -v grep | grep -v bounce.sh | awk '! /0:00.00/ {print $2 ;}'`
		echo "$app is now running under PID $pid"
	else
		echo "Cancelling the bounce of $app"
    	fi
    fi
fi
