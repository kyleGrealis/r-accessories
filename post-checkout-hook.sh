#!/bin/bash

# Path to your 'projects' directory
projects_dir="$HOME/projects"

# Path to the 'post-checkout' file in 'projects'
post_checkout_file="$HOME/projects/post-checkout"

# Iterate over all directories in 'projects'
for dir in "$projects_dir"/*; do
    # Check if the directory is a Git repository
    if [ -d "$dir/.git" ]; then
        # Copy the 'post-checkout' file to the '.git/hooks/' directory
        cp "$post_checkout_file" "$dir/.git/hooks/"
        echo "Added post-checkout hook to $dir"
        
        # Make the 'post-checkout' file executable
        chmod +x "$dir/.git/hooks/post-checkout"
        echo "post-checkout hook executable and ready to help in $dir"
    fi
done

