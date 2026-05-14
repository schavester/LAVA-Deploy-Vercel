#!/bin/bash

# Initialize a counter
count=0

echo "Starting edge request optimization..."
echo "------------------------------------"

# This will find index.html at ANY depth starting from where the script is run
find . -name "index.html" | while read -r file; do
    # Increment counter
    ((count++))
    
    # Output the current file being processed to the screen
    echo "[$count] Optimizing: $file"

    # 1. Remove the Emoji Javascript block
    sed -i '' '/window._wpemojiSettings/,/}(window,document,window._wpemojiSettings);/d' "$file"

    # 2. Remove all DNS Prefetch lines
    sed -i '' '/link rel="dns-prefetch"/d' "$file"

    # 3. Remove WP metadata and oembed links
    sed -i '' '/meta name="generator" content="WordPress/d' "$file"
    sed -i '' '/link rel="shortlink"/d' "$file"
    sed -i '' '/link rel="alternate" type="application\/json+oembed"/d' "$file"
    sed -i '' '/link rel="alternate" type="text\/xml+oembed"/d' "$file"

    # 4. Remove the Emoji CSS block
    sed -i '' '/img.wp-smiley,img.emoji {/,/background: none !important;	padding: 0 !important;}/d' "$file"
done

echo "------------------------------------"
echo "Success! Total files processed: $count"