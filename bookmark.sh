#!/bin/bash
# created by Mathis - 8 Feb 2024 
#
#

save_last_commands() {
    local num_commands=$1
    local comment="$2"

    # Check if the input is a valid positive integer
    if ! [[ "$num_commands" =~ ^[0-9]+$ ]] || [ "$num_commands" -le 0 ]; then
        echo "Bro, you gotta give me a positive integer for the number of commands."
        return 1
    fi

    # If a comment is provided, append it to the file
    if [[ -n "$comment" ]]; then
        echo -e "\n# $comment" >> ~/commands.txt
    else 
        echo -e "\n" >> ~/commands.txt
    fi

    # Special handling for saving just the last command
    if [ "$num_commands" -eq 1 ]; then
        # Fetch the last command excluding this script and the command triggering this script
        history | tail -n 1 | head -n 2 | sed 's/^[ ]*[0-9]*[ ]*//' >> ~/commands.txt
    else
        # Append the last X commands to the file, adjusting for script invocation
        history | tail -n $((num_commands + 1)) | head -n $num_commands | sed 's/^[ ]*[0-9]*[ ]*//' >> ~/commands.txt
    fi
}

# Main function to parse arguments and call save_last_commands
main() {
    local num_commands=1 # Default number of commands to save
    local comment=""
    local has_c_option=false

    # Parse options
    while getopts ":c:" opt; do
        case $opt in
            c) comment=$OPTARG; has_c_option=true;;
            ?) echo "Unknown option: -$OPTARG" >&2; return 1;;
        esac
    done

    shift $((OPTIND - 1))

    # If there are remaining arguments after option parsing
    if [ "$#" -gt 0 ]; then
        num_commands=$1
    fi

    # If the -c option was used without specifying the number of commands
    if [ "$has_c_option" = true ] && [ "$#" -eq 0 ]; then
        num_commands=1 # Ensure there's a default if only -c is used without number
    fi

    save_last_commands "$num_commands" "$comment"
}

main "$@"
