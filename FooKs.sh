#!/bin/bash


# Made by David Roldan (D4RP1)

# Variables

# Colors
RED='\033[00;31m' GREEN='\033[00;32m' YELLOW='\033[00;33m' BLUE='\033[00;34m'
PURPLE='\033[00;35m' CYAN='\033[00;36m' LIGHTGRAY='\033[00;37m' LRED='\033[01;31m'
LGREEN='\033[01;32m' LYELLOW='\033[01;33m' LBLUE='\033[01;34m' LPURPLE='\033[01;35m'
LCYAN='\033[01;36m' WHITE='\033[01;37m' RESTORE='\033[0m'

# Book lists
MPLIST=$(curl 'https://www.gutenberg.org/ebooks/search/?sort_order=downloads' 2> /dev/null |
grep 'class="title"' | tail -n25 | sed 's/<span class="title">//p' | sed -e 's/<\/span>//p' | uniq | tr '[:lower:]' '[:upper:]' )
MPARRAY=($MPLIST)

IDBLIST=$(curl 'https://www.gutenberg.org/ebooks/search/?sort_order=downloads' 2> /dev/null |
grep 'class="link"' | tail -n25 | sed 's/<a class="link" href="\/ebooks\///p' | sed -e 's/"//p' | uniq | cut -d" " -f1)
IDBARRAY=($IDBLIST)

# Main
TITLEFLGT=$(figlet 'FooKs')
echo -e "$TITLEFLGT"
echo -e "$LPURPLE¡¡Welcome to Fooks!!$RESTORE -📖-$LCYAN Popular Books $RESTORE-📚-"
echo -e "$LYELLOW ID		BOOK $RESTORE"

# Functions

function bookshow () {
	SAVEIFS=$IFS
	IFS='
	'
	I=0
	for lib in $MPLIST; do
		if [ ${IDBARRAY[$I]} -lt 99 ]; then
			echo -e ${CYAN} "$(echo ${IDBARRAY[$I]}) $RESTORE   ---> $lib"
                elif [ ${IDBARRAY[$I]} -lt 999 ]; then
                        echo -e ${CYAN} "$(echo ${IDBARRAY[$I]}) $RESTORE  ---> $lib"         
                elif [ ${IDBARRAY[$I]} -lt 9999 ]; then
                        echo -e ${CYAN} "$(echo ${IDBARRAY[$I]}) $RESTORE ---> $lib"          
                elif [ ${IDBARRAY[$I]} -lt 99999 ]; then
                        echo -e ${CYAN} "$(echo ${IDBARRAY[$I]}) $RESTORE---> $lib"          
                fi
		I=$((I+1))
	done
	IFS=$SAVEIFS
}

function nmbook () {
	NAMBOOK=$(curl https://www.gutenberg.org/ebooks/$1 2> /dev/null |
		grep h1 | sed -e 's/<h1 itemprop="name">//p' | sed 's/<\/h1>//p' | uniq)
	echo "$NAMBOOK"
}

function downread () {
# ROD = $1
# CHOOSENBOOK = $2

	if [ $1 = "R" -o $1 = "r" ]; then
		curl "https://www.gutenberg.org/files/$2/$2-0.txt" 2> /dev/null | less
        elif [ $1 = "D" -o $1 = "d" ]; then
		curl "https://www.gutenberg.org/files/$2/$2-0.txt" 2> /dev/null -o $(nmbook $2)
        else
		echo "$LRED[*] Enter |R| or |D|$RESTORE"
	fi
}

# The bookshow function is called
bookshow

echo -e "$LPURPLE Write the ID of the Book to Download or Read:$RESTORE "
read -p " " CHOOSENBOOK
read -p "¿Read or Download?  R | D  ->" ROD

# The downread function is called
downread $ROD $CHOOSENBOOK
















