ShellScrippz
============

Just a small collection of shell scripts I wrote. Some might be useful...some might not.

### Act On List 
The point of this script is to run the same command on long list of files or directories.  
For example, you may have a big list of files that you want to delete to clean up your filesystem. This script will loop through the specified input file and perform the specified command (rm in this case)
Let's walk through a run for even more clarity.    
Our input might look something like this:
```
/tmp/temp1.txt
/tmp/temp2.txt
/tmp/temp3.txt
/tmp/temp4.txt
/tmp/temp5.txt
```
Execution processes as follows:
```
mac:ActOnList thomasforzaglia$ ./processList.sh 
Enter the name of the input file
input.txt
Enter the command you want to run on the input file
rm
```

### Bounce Mac App
This script can be used to start or bounce a Mac application that is installed in the /Applications directory.   
Let's walk through a run for clarity's sake.     
First of all, you'll want to specify the name of the app as a command line argument
```
mac:BounceMacApp thomasforzaglia$ ./bounce.sh 
Enter the name of the app you want to bounce as an argument on the command line.
Example: ./bounce.sh Mail
```
Let's bounce Xcode now. The script will give you the opportunity to confirm the bounce.
```
mac:BounceMacApp thomasforzaglia$ ./bounce.sh xcode
xcode is running under 1404
Are you sure you want to restart xcode [y/n]?
y
xcode is now running under PID 1461
```
Now what if the specified app isn't running? The script will give you the option to start it up.
```
mac:BounceMacApp thomasforzaglia$ ./bounce.sh xcode
xcode is not currently running. Would you like to start it [y/n]?
y
xcode is now running under PID 1509
```

### Rotate Logs
This is a simple log rotation script which can be added to cron tab to make it run automatically. A few parts of the script need to be edited based on a user's specific situation.     
The following lines in particular should be customized:
```
cd /Users/forzaglia/Documents/test
gzip -c SysOut.log>SysOut.log.$ext.gz
>SysOut.log

subject="AUTO: SysLog -- $ext"
email="thomas.forzaglia@mlb.com"
body="/Users/forzaglia/Documents/test/emailmessage.txt"
echo "Automatic log rotation has been performed in the /Users/forzaglia/Documents/test path."> $body
```
