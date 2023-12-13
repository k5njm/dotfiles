#!/bin/bash

# URL of your GitHub public keys
GITHUB_KEYS_URL="https://github.com/k5njm.keys"

# File to store authorized keys
AUTHORIZED_KEYS="$HOME/.ssh/authorized_keys"

# Create the file if it doesn't exist
mkdir -p ~/.ssh/
touch "$AUTHORIZED_KEYS"

# Fetch and add keys if they don't already exist
curl -s "$GITHUB_KEYS_URL" | while read -r key; do
    if ! grep -qF -- "$key" "$AUTHORIZED_KEYS"; then
        echo "$key" >> "$AUTHORIZED_KEYS"
    fi
done
