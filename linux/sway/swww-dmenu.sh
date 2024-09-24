#!/bin/bash
#
# dmenu wallpaper picker
#

# Configure directory containing your wallpapers
WALLPAPER_DIR="$HOME/Pictures/wallpaper*"


# List all image files in the directory and store both full paths and processed
# filenames
WALLPAPERS=($(find $WALLPAPER_DIR -type f -print0 | xargs -0 file --mime-type |
    grep -F 'image/' | cut -d ':' -f 1 | sort))

BASENAME=
SELECTED_NAME=
FILENAMES=()
for WALLPAPER in "${WALLPAPERS[@]}"; do
    BASENAME=$(basename "$WALLPAPER")
    FILENAME_WITHOUT_EXT="${BASENAME%.*}"
    CAPITALIZED_NAME=$(echo "$FILENAME_WITHOUT_EXT" | sed 's/.*/\u&/')
    FILENAMES+=("$CAPITALIZED_NAME")
done

# If no wallpapers are found, exit the script
if [ ${#FILENAMES[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Use wofi to select a wallpaper (showing capitalized filenames without
# extensions)
SELECTED_NAME=$(printf "%s\n" "${FILENAMES[@]}" | 
    wofi -d -O default -p "Select a wallpaper...")

# Map the selected name back to the corresponding full path
for i in "${!FILENAMES[@]}"; do
    if [ "${FILENAMES[$i]}" == "$SELECTED_NAME" ]; then
        SELECTED="${WALLPAPERS[$i]}"
        break
    fi
done

# Debugging output
echo "Selected wallpaper: $SELECTED"

# If a wallpaper was selected, set it using swww
if [ -n "$SELECTED" ]; then
    # This script ensures swww-daemon is running and applies transition fx
    ${BASH_SOURCE%/*}/swww.sh "$SELECTED"
    # swww img "$SELECTED"
    # wal -i "$SELECTED" >> /tmp/wallpaper_switcher.log 2>&1
    # pywal-spicetify text >> /tmp/wallpaper_switcher.log 2>&1
    # sh .script/wofi_pywal.sh >> /tmp/wallpaper_switcher.log 2>&1
    # pywalfox update >> /tmp/wallpaper_switcher.log 2>&1
else
    echo "No wallpaper selected."
    exit 0
fi
