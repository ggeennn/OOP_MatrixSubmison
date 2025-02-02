#!/bin/bash

# Compile the code
g++ -Wall -std=c++11 -g -o ws *.cpp

# Check if the compilation was successful
if [ $? -eq 0 ]; then
    echo "Compilation successful, running the program..."
    
    # Run valgrind and display all output while only recording the ws program's output to program_output.txt
    valgrind --show-error-list=yes --leak-check=full --show-leak-kinds=all --track-origins=yes ws | tee program_output.txt

    # Prompt the user if there is a correct_output.txt with input validation
    valid_input=false
    while [ "$valid_input" = false ]; do
        read -p "Is there a correct_output.txt? (y/n): " response
        if [[ "$response" == [Yy]* ]]; then
            # Check if correct_output.txt exists
            if [ -f "correct_output.txt" ]; then
                echo "Comparing program output with correct_output.txt..."
                diff program_output.txt correct_output.txt
                
                # Check if diff found any differences
                if [ $? -eq 0 ]; then
                    echo "No differences found. The outputs are identical."
                else
                    echo "Differences found between program output and correct_output.txt."
                fi
            else
                echo "correct_output.txt does not exist, unable to compare."
            fi
            valid_input=true
        elif [[ "$response" == [Nn]* ]]; then
            echo "No comparison will be made."
            valid_input=true
        else
            echo "Please answer y or n."
        fi
    done
else
    echo "Compilation failed, please check the code."
fi

# Check if the compiled file exists and prompt for overwrite
if [ -f "ws" ]; then
    echo "The compiled file 'ws' already exists. It will be overwritten."
fi