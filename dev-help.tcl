##############################################################################
# dev-irchelp v1.0 by devvis                                                 #
# If you don't want the standard !help to be used, change it below.          #
# Also, please specify the path to your dev-ircrules.sh below at "set dbin"  #
##############################################################################
bind pub -|- !help pub:help

set dbin "/full/path/to/dev-help.sh"

proc pub:help {nick output binary chan text} {
	global dbin
	foreach line [split [exec $dbin] "\n"] {
		putquick "PRIVMSG $nick :$line"
#		sleep(1)
	}
}
putlog "dev-irchelp v1.0 by devvis loaded"
