#!/bin/bash
lastspam=0
lastmsg=0
lastnick="dafs"
shopt -s nocasematch
function speak {
shuf -n 1 Noisy.TXT
}
function roll {
shuf -i $1-$2 -n 1
}
tail -f -n 0 out | \
    while read -r date time nick msg; do
	if [ $nick != "<Noisy>" ] && [ $nick != "-!-" ]; then	
		
		SLEEP=$(roll 4 7)
		q=$(roll 1 100)
		y=$(roll 1 100)
		
		case $msg in
		*nois*|*latv*|*rocketball*|*fix*|*feature*|*project*)
		lastnick=$nick 
		;;
		*)
		if [ $y -eq 9 ]; then
		lastnick=$nick
		fi
		;;
		esac
		
		if [ "$nick" == "$lastnick" ]; then
			
			if [ $q -lt 25 ]; then
			lastnick="dafs"
			fi

			if [ $q -gt 90 ]; then
			say="$(speak)"
			name="$(echo $nick | tr -d '<>')"
			speech="$(echo $name: $say)"
			else
			speech="$(speak)"
			fi

			if [ "$[ $(date +%s) - lastspam ]" -gt "4" ];
			then
				if [[ $msg != *!noisy* ]] && [[ $msg != *bot* ]]; then
					if [ "$msg" != "$lastmsg" ]; then				
					sleep $SLEEP
					echo "$speech"
					lastmsg="$msg"
					lastspam=$(date +%s)
					fi
				fi
				if [ $q -eq 7 ]; then
				sleep 2s
				echo "P.S: ^_^"
				fi
			fi
		fi
	
		if [ "$lastnick" == "dafs" ]; then
			if [ $q -gt 85 ];
			then
			lastnick=$nick
			sleep 6s	
			say="$(speak)"
			name="$(echo $nick | tr -d '<>')"
			echo "$name: $say"				
			fi
		fi
	fi

    done > in
