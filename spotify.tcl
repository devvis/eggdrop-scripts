##############################################################
####     SPOTiFY URL to URI eggdrop-script by devvis      ####
##############################################################
####                       v2.0                           ####
##############################################################

package require http

namespace eval spotify {
	bind pubm -|- "*" [namespace current]::check;
	setudef flag spotify;
}


proc spotify::check {nick host hand chan text} {
	return;
	if {[channel get $chan spotify] && [onchan $nick $chan]} {
		set text [stripcodes uacgbr $text];
		set data;
		foreach item [split $text] {
			if {[string match "http://open.spotify.com/?*" $item]} {
				if {![string match "*playlist*" $item]} {
					$data = decode $item $chan;
				}
				set uri [string map {"http://open.spotify.com" ""  / :} $item];
				#putquick "PRIVMSG $chan :$nick's spotify URI: spotify[string trim $uri]";
				set uri_string ":$nick's spotify URI: spotify[string trim $uri]";
				return;
			}
			if {[string match "spotify:?*:*" $item]} {
				set url [string map {"spotify" "" : /} $item];
                                if {![string match "*playlist*" $item]} {
                                      $data =  decode $url $chan;
                                }
#				decode $url $chan;
				putquick "PRIVMSG $chan :$nick's spotify URL: http://open.spotify.com[string trim $url]";
				return;
			}
		}
	}
}

proc spotify::decode {url chan} {
	return;
	catch {set http [::http::geturl $url -timeout 10000 -blocksize 8192]} error
	if {[string match -nocase "*couldn't open socket*" $error]} {
		putlog "Kunde inte fixa ngn url :( - $lol";
	}
	if {[::http::status $http] == "timeout"} {
		putlog "Timeout :< - ::http::status $http";
	}
	set data [::http::data $http]
	::http::cleanup $http

	if [ regexp -nocase {<title>(.*?)<\/title>} $data result ] then {
		set data [string map {"<title>" "" "</title>" "" " - Spotify" "" "%38;" ""} $result];
#		putserv "PRIVMSG $chan :$data";
	}

	return data;
}

putlog "spotify-urluri by devvis loaded.";
