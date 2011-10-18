#!/bin/bash
VER=1.0
#-[ Intro ]------------------------------------------------------#
#                                                                #
# dev-irchelp is a script for eggdrop used to display the        #
# channel help/rules directly from IRC                           #
#                                                                #
# It just reads the help-file and then sends it in a private     #
# message to the user.                                           #
#                                                                #
#-[ Setup ]------------------------------------------------------#
#                                                                #
# To use it, just copy this file to some nice dir.               #
# Then chmod it to 755 so that it can be executed.               #
#                                                                #
# Add rules by editing dev-help.list and add one rule per line.  #
#                                                                #
# For dev-help.tcl, just copy the file into your eggdrops        #
# script-dir, and then add this line to your eggdrop-config:     #
#                                                                #
# source script/dev-help.tcl                                     #
#                                                                #
# And then .rehash your eggy :)                                  #
#                                                                #
#-[ Configuration ]----------------------------------------------#
#                                                                #
# Edit the following variables;                                  #
#                                                                #
#  eggroot = Your eggdrop-root dir. Don't forget the "/" at the  #
#            end.                                                #
# helpfile = Name of your help-file                              #
#                                                                #
#-[ Settings ]---------------------------------------------------#

eggroot=/path/to/eggdrop/scripts/
helpfile=dev-help.list

#-[ Start of script ]--------------------------------------------#

VER="1.1"

## Is the first argument debug?
if [ "$1" = "debug" ]; then
	DEBUG="TRUE"
else
	DEBUG="FALSE"
fi

## Debug-proc
proc_debug() {
	if [ "$DEBUG" = "TRUE" ]; then
		echo "$*"
	fi
}

## Prints some debug-info
if [ $DEBUG = "TRUE" ]; then
	proc_debug "dev-help.sh version $VER loaded."
fi

## Do we have access to the rules-file?
if [ ! -r $eggscripts$helpfile ]; then
	echo "Error. Cannot read the rules from $helpfile. Correct path and permissions?"
	exit 1
fi

## Read how many lines that file contains :)
if [ $DEBUG = "TRUE" ]; then
	LINE=`cat $eggscripts$helpfile | wc -l`
	proc_debug "$LINE"
fi

## Lets merge those thingys togeather
fname=$eggscripts$helpfile
exec<$fname
x=0
while read -r line
do
	value=`expr $x + 1`
	echo $line
done
## Goodbye!
exit 0
