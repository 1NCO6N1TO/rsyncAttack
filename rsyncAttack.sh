#!/bin/bash

ip=""
wordlist=""

# Function to handle Ctrl+C
function ctrl_c() {
    echo -e "\n[!] Exiting the script... Goodbye.\n"
    exit 1
}

# Capture Ctrl+C
trap ctrl_c INT

# Handling options
while getopts ":i:w:" opt; do
    case ${opt} in
        i ) 
            ip=$OPTARG
            ;;
        w )
            wordlist=$OPTARG
            ;;
        \? )
            echo "Invalid option: -$OPTARG" 1>&2
            ;;
        : )
            echo "Option -$OPTARG requires an argument" 1>&2
            ;;
    esac
done

# Skip processed arguments
shift $((OPTIND - 1))

# Check for mandatory arguments
if [ -z "$ip" ] || [ -z "$wordlist" ]; then
    echo "Usage: $0 -i <ip> -w <wordlist>"
    exit 1
fi

# Check if the wordlist file exists
if [[ ! -f "$wordlist" ]]; then
    echo "The provided wordlist does not exist"
    exit 1
fi

# Extract the file name from the path
diccionario="${wordlist##*/}"

# Display basic information
echo -e "\n[+] Target IP: $ip"
echo -e "[+] Wordlist: $diccionario"

# Count the total number of words in the wordlist
total=$(wc -l < "$wordlist")
echo -e "[+] Total number of words in the wordlist: $total\n"

# Read and test each word in the wordlist
while IFS= read -r WORD; do
    echo -ne "\r\033[K[-] Testing word: $WORD"

    # Test the word using rsync with a 5-second timeout and capture the output
    OUTPUT=$(timeout 0.5 bash -c "rsync -av --list-only rsync://$ip/$WORD" 2>/dev/null)

    # Check if rsync was successful
    if [ $? -eq 0 ]; then
        echo -e "\n[+] Password found: $WORD"
        echo -e "\n[+] Output:\n$OUTPUT"
        exit 0
    fi

done < "$wordlist"

echo -e "\n[-] Password not found"
exit 1
