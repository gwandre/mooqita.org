#!/bin/bash

# Config variables
maxFileSize=1048576
uidSize=15
outputCrudeFile=challengeCrudeOutput
outputFinalFile=challengeFinalOutput

# Calc total lines to get in RANDOM (divid total bytes by UID Size plus a line break)
totalLines=$(expr $maxFileSize / $(expr $uidSize + 1) )

# Generate a Random UID list with 15 ALPHANUMERIC characters
# Used /dev/urandom to generate random data
# Then used tr to "translate" to readable characters
# Then used fold to "fold" contents to "$uidSize" total columns
# Then took the first "$totalLines" lines from the result with "head"
cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $uidSize | head -n $totalLines > $outputCrudeFile

# Sort the file
# Used the "-o" option instead of "sort file > file" because the first one writted a blank file
sort -o $outputCrudeFile $outputCrudeFile

# Filter file deleting lines matching the first char 'A' or 'a' and write to a new Final File
sed -r '/^[aA].*/d' $outputCrudeFile > $outputFinalFile
