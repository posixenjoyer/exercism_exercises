#!/usr/bin/env bash

# The following comments should help you get started:
# - Bash is flexible. You may use functions or write a "raw" script.
#
# - Complex code can be made easier to read by breaking it up
#   into functions, however this is sometimes overkill in bash.
#
# - You can find links about good style and other resources
#   for Bash in './README.md'. It came with this exercise.
#
#   Example:
#   # other functions here
#   # ...
#   # ...
#
#   main () {
#     # your main function code here
#   }
#
#   # call main with all of the positional arguments
#   main "$@"
#
# *** PLEASE REMOVE THESE COMMENTS BEFORE SUBMITTING YOUR SOLUTION ***
#

input=$1

# External Command
# echo "${input[0]}" | rev

# Loop Solution
#
reverse=''
# Forward Loop
# for ((i = 0; i < ${#input}; i++)); do
# 	reverse=${input:i:1}$reverse
# done
# echo "$reverse"

# Reverse Loop
for ((i = ${#input}; i >= 0; i--)); do
	reverse+=${input:i:1}
done
echo "$reverse"
