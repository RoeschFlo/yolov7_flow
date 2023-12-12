#!/bin/bash

# Check if the user provided the directory as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

# Get the directory path from the argument
directory="$1"

# Check if the provided directory exists
if [ ! -d "$directory" ]; then
  echo "Error: Directory '$directory' not found."
  exit 1
fi

# Iterate through each .txt file in the directory
for file in "$directory"/*.txt; do
  # Skip if the file is not a regular file
  [ -f "$file" ] || continue

  # Create a temporary file to store the modified content
  tmp_file=$(mktemp)

  # Process each line in the file
  while IFS= read -r line; do
    # Remove the 6th column (assumes columns are space-separated)
    modified_line=$(echo "$line" | awk '{$6=""; print $0}' | tr -s ' ')

    # Append the modified line to the temporary file
    echo "$modified_line" >> "$tmp_file"
  done < "$file"

  # Overwrite the original file with the modified content
  mv "$tmp_file" "$file"

  # Remove the temporary file
  rm "$tmp_file"
done

