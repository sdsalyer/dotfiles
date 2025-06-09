#!/bin/bash
#
# Script to check for new emails in aerc accounts

# for waybar or other "count" uses, we pass in -q to make it quiet
exec 3>&1
if [ "$1" = "-q" ]; then
    exec 1>/dev/null
else 
    exec 1>&3
fi

aerc_config=$(cat $HOME/.config/aerc/accounts.conf)

if [[ -z "$aerc_config" ]]; then
    echo "No aerc accounts found."
    exit 1
fi

accounts=()
mailsources=()
mailboxes=()
pws=()

# Extract username from aerc mailsource
get_user_from_mailsource() {
    local url="$1"
    local username=$(echo "$url" | sed -E 's/.*\/\/([^@]+)@.*/\1/')
    username="${username//%40/@}" # Replace %40 with @
    echo "$username"
}

# Extract value from aerc config line
get_value_from_line() {
    local line="$1"
    local key="$2"
    echo "$line" | grep -oE "^$key\s*=\s*(.*)$" | 
        awk '{for (i=3; i<=NF; i++) printf "%s ", $i}'
}

# Remove special characters and convert to lowercase
sanitize_key() {
    local key="$1"
    key="${key//[^a-zA-Z0-9_]/_}"
    key="${key,,}"
    echo "$key"
}

# Loop through each account
while IFS= read -r line; do
    # Skip empty lines and comments
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    # Extract the account name and password from the line
    account=$(echo "$line" | grep -oE "\[.*\]" | tr -d '[]')
    if [[ -n "$account" ]]; then
        accounts+=("$account")
    fi

    mailsource=$(get_value_from_line "$line" "source")
    if [[ -n "$mailsource" ]]; then
        mailsources+=("$mailsource")
    fi

    mailbox=$(get_value_from_line "$line" "default")
    if [[ -n "$mailbox" ]]; then
        mailboxes+=("$mailbox")
    fi

    pw_cmd=$(get_value_from_line "$line" "source-cred-cmd")
    if [[ -n "$pw_cmd" ]]; then
        pws+=("$pw_cmd")
    fi

done <<< "$aerc_config"

# Array to hold message counts
declare -A new_messages
new_messages[total]=0

for i in "${!mailsources[@]}"; do
    account="${accounts[$i]}"
    mailsource="${mailsources[$i]}"
    mailbox="${mailboxes[$i]}"
    pw_cmd="${pws[$i]}"

    if [[ -z "$pw_cmd" ]]; then
        echo "No password command found for account $account."
        continue
    fi

    # Get the password using the command
    password=$(eval "$pw_cmd")
    if [[ -z "$password" ]]; then
        echo "Failed to retrieve password for account $account."
        continue
    fi

    echo "Checking [$(echo "$mailbox" | tr -d ' ')] of $account"

    username=$(get_user_from_mailsource "$mailsource")
    #echo "curl -s $mailsource -u $username:$password -X \"EXAMINE $mailbox\" 2>&1 | grep -o '[0-9]\+\s*EXISTS' | awk '{print $1}'"
    new_emails=$(curl $mailsource -u $username:$password -X "EXAMINE $mailbox" 2>&1 | grep -o '[0-9]\+\s*EXISTS' | awk '{print $1}')

    account_key=$(sanitize_key "$account")
    if [[ -n "$new_emails" ]]; then
        echo "> You have $new_emails new message(s)."
        new_messages[total]=$((new_messages[total] + new_emails))
        new_messages[$account_key]=$new_emails
    elif [[ "$new_emails" == "0" ]]; then
        echo "> No new messages."
        new_messages[$account_key]=0
    else
        echo "> !! Failed to check new messages !!"
        new_messages[$account_key]="error"
    fi
done

msg=""
if [[ ${new_messages[total]} -gt 0 ]]; then
    tmp="${new_messages[total]} new emails:"
    echo "$tmp"
    msg="$tmp"

    for account in "${!new_messages[@]}"; do
        if [[ "$account" != total ]]; then
            tmp="> ${new_messages[$account]}: $account"
            echo "$tmp"
            msg+="\n$tmp"
        fi
    done

    notify-send "New Emails" "$msg"
else
    echo "No new messages across all accounts."
fi

# turn echo back on if -q was used
if [ "$1" = "-q" ]; then
    exec 1>&3
fi

#echo "${new_messages[total]}"
printf '{"text": "%s", "tooltip": "%s"}\n' "${new_messages[total]}" "$msg"

