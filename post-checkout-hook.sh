#!/bin/bash

# Path to your 'repo' directory
repo_dir="/c/Users/kxg679/Desktop/repos"

# Path to the 'post-checkout' file in 'repos'
post_checkout_file="/c/Users/kxg679/Desktop/repos/post-checkout"

# Iterate over all directories in 'repo'
for dir in "$repo_dir"/*; do
    # Check if the directory is a Git repository
    if [ -d "$dir/.git" ]; then
        # Copy the 'post-checkout' file to the '.git/hooks/' directory
        cp "$post_checkout_file" "$dir/.git/hooks/"
        echo "Added post-checkout hook to $dir"
    fi
done
