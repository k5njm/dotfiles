#!/bin/bash

# Path to the authorized_keys file
authorized_keys_file="$HOME/.ssh/authorized_keys"

# Backup the current authorized_keys file
cp "$authorized_keys_file" "${authorized_keys_file}.bak"

# Make the API call and overwrite the authorized_keys file
curl -sL \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $(gh auth token)" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/keys | \
  jq -r '.[] | "# Title: \(.title), Created at: \(.created_at)\n\(.key)\n"' > "$authorized_keys_file"

echo "Authorized Keys:"
cat authorized_keys_file