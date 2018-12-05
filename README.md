# mooqita.org
Chalenges from mooqita.org

1) Challenge YKgnjCTtuD2AoAmu2 (Linux challenge - beginner)

Two bash scripts was created:
  1: challenge_slow.sh
      It's using a loop to write into a file the random data, line by line
      
  2: challenge_fast.sh
      BEST CHOICE! Write in less than a second a file with 1MiB of random UID (with a length of 15 chars) exploring the "fold" command

TIPS:
  a) Used /dev/urandom to generate random data with "tr" to translate into readable data
  b) Used "fold" command to fold the data into a column with 15 chars length
  c) REMEMBER to SUM the "\n" char of each line
  d) Used the "-o" option instead of "sort file > file" because the first one writted a blank file
  e) Used the "sed" with a REGEX '/^[aA].*/d' to remove lines starting with "a" or "A"

Final Question: "How many lines were removed?"
  Every test I got different number of lines removed, but, at the last commit I got 2100 lines with thi command:
  $ diff challengeCrudeOutput challengeFinalOutput | wc -l
