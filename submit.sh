#!/bin/bash

# Define constants
SUBJECT_CODE="44"
SECTION="ncc"

# Prompt user for workshop number with input validation
while true; do
    read -p "Enter the workshop number (1-10): " WORKSHOP_NUMBER
    if [[ "$WORKSHOP_NUMBER" =~ ^(10|[1-9])$ ]]; then
        break  # Valid input, exit the loop
    else
        echo "Invalid workshop number. Please enter a number between 1 and 10."
    fi
done

# Prompt user for submission type with input validation
while true; do
    read -p "Do you want to submit lab or reflection? (lab/ref): " SUBMISSION_TYPE
    if [[ "$SUBMISSION_TYPE" == "lab" ]]; then
        COMMAND="~reza.khojasteh/submit 2$SUBJECT_CODE/w$WORKSHOP_NUMBER/lab_$SECTION"
        break  # Valid input, exit the loop
    elif [[ "$SUBMISSION_TYPE" == "ref" ]]; then
        COMMAND="~reza.khojasteh/submit 2$SUBJECT_CODE/w$WORKSHOP_NUMBER/ref_$SECTION"
        break  # Valid input, exit the loop
    else
        echo "Invalid submission type. Please enter 'lab' or 'ref'."
    fi
done

# Output the command
echo "Your submission command is:"
echo "$COMMAND"

# Execute the submission command
eval "$COMMAND"