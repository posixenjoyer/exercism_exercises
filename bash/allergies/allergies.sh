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
#

declare -a allergens
allergens[1]="eggs"
allergens[2]="peanuts"
allergens[4]="shellfish"
allergens[8]="strawberries"
allergens[16]="tomatoes"
allergens[32]="chocolate"
allergens[64]="pollen"
allergens[128]="cats"

bit_indicator=1
input=$1
output=""
allergic="false"

while [[ $bit_indicator -lt 129 ]]; do
	if ((input & bit_indicator)); then
		output+="${allergens[$bit_indicator]} "
	fi
	((bit_indicator *= 2))
done

if [ "$2" = "list" ]; then
	echo "${output% }"
elif [ "$2" = "allergic_to" ]; then
	if [[ $DEBUG = "true" ]]; then
		echo "Output = ${output}"
		echo "ARG 3 = $3"
	fi
	if [[ "${output% }" = *"$3"* ]]; then
		allergic="true"
	fi
	echo ${allergic}
fi
