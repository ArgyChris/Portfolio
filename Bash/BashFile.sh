#!/bin/sh
#The previous is the shebang line that defines the use of the appropriate intrepreter (effort for POSIX compliance, check with shellcheck)

#Exercise input variables
#	pathlocation: absolute path to the search location
#	suffix: suffix to search the files under the pathlocation
#	writefilename: filename (.txt) to write the list of the found files
#	regularexpression: applied regular expression to sort the results, it accepts an empty
#Example usage:
#	./Exercise1.sh /home/argy/Portfolio/Bash .txt /home/argy/Portfolio/Bash/output.txt f......t
#    example for the regular expression:
#		[empty]: no regular expression, or no filtering
#		f......t: select the file if somewhere there is a sequence that start with "f" have 6 random characters between and end with "t"
#		f...3...t: select if somwhere there is a sequence that start with "f" then has 3 random characters, next a "3", followed by 4 random, and ends with "t"

pathlocation=$1
suffix=$2
writefilename=$3
regularexpression=$4

echo
echo Input variables:
echo pathlocation:"$pathlocation"
echo suffix:"$suffix"
echo output filename:"$writefilename"
echo regular expression:"$regularexpression"
echo

#Function to check the input path, find the subfiles that satisfy the regular expression,
#and that writes to the target location
#Input variables:
#	$1: pathlocation
#	$2: suffix
#	$3: output filename
#	$4: regular expression, it accepts empty
#Ourput:
#	writes in the output file the files row-by-row
processfiles()
{	
    if [ -d "$1" ]; then
	echo The input pathlocation is a directory	
	case "$4" in
		'')
			echo Write files without applying any regular expression		
			find "$1" -type f -name "*$2" > "$3"
			echo Success
			;;		
		*)
			echo Write files that satisfy the regular expression: "$4"
			find "$1" -type f -name "*$2" | grep "$4" > "$3"
			echo Target file for the output: "$3"
			echo Success
			;;		
	esac
	elif [ -f "$1" ]; then
		echo The input pathlocation is a file, please rerun
		echo "$1"		
	else
		echo The pathlocation is an invalid input, please rerun		
		exit 1
	fi
}

#Call of the main function
processfiles "$pathlocation" "$suffix" "$writefilename" "$regularexpression"





