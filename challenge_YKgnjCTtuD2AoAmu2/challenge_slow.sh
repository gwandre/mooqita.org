#!/bin/bash

# Config variables
maxFileSize=1048576
uidSize=15
outputCrudeFile=challengeCrudeOutput
outputFinalFile=challengeFinalOutput

# Define a function to generate a Random UID with 15 ALPHANUMERIC characters
function getRandomUID() {
	# Used /dev/urandom to generate random data
	# Then used tr to "translate" to readable characters
	# Then used fold to "fold" contents to "$uidSize" total columns
	# Then took the first line from the result with "head"
	echo $(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $uidSize | head -n 1)
}

# Define a function to read the actual file size
function getFileSize() {
	# Used du command to get file size with "-b" parameter to get the result in "Bytes"
	# Then cuted the contents to the first column
	echo $(du -b $outputCrudeFile | cut -f1)
}

# Reset output files
> $outputCrudeFile
> $outputFinalFile

# Run a loop until filesize is greater or equal to the $maxFileSize
until [ $(getFileSize) -ge $maxFileSize ]
do
	echo $(getRandomUID) >> $outputCrudeFile
done

# Sort the file
# Used the "-o" option instead of "sort file > file" because the first one writted a blank file
sort -o $outputCrudeFile $outputCrudeFile

# Filter file deleting lines matching the first char 'A' or 'a' and write to a new Final File
sed -r '/^[aA].*/d' $outputCrudeFile > $outputFinalFile
