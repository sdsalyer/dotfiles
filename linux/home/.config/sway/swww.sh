#!/bin/bash
#
# start swww daemon and set wallpaper
#

# start wallpaper daemon if needed
swww query &> /dev/null
if [ $? -ne 0 ]; then
    swww-daemon --format xrgb &
fi


#######################
# Handle setting of the wallpaper
DEFAULT_BACKGROUND=$HOME/Pictures/wallpapers/wallhaven-2yxo29.png
SYMLINK_PATH=$HOME/Pictures/wallpapers/current.wallpaper

if [ -n "$1" ]; then
    #######################
    # params:
    # force create symlink to param
    #######################
    symlink_target=$1
    ln -sf "${symlink_target}" "${SYMLINK_PATH}"
else
    #######################
    # no params:
    #   if symlink does not exist:
    #     create symlink to default bg
    #   call swww -> symlink
    #######################
    symlink_target=$(readlink "${SYMLINK_PATH}" 2>&1)
    if ! [ -n "${symlink_target}" ]; then
        symlink_target=$DEFAULT_BACKGROUND
        echo "[wallpaper] creating symlink: ${SYMLINK_PATH} -> ${symlink_target}"
        ln -sf "${symlink_target}" "${SYMLINK_PATH}"
    fi
fi

# call swww -> symlink
echo "[wallpaper] calling swww for: ${SYMLINK_PATH} -> ${symlink_target}"

# set wallpaper
xtrans="grow"
wallTransDuration=0.4
wallFramerate=60
#    --invert-y \
#    --transition-pos "$(hyprctl cursorpos)" \
swww img \
    "${SYMLINK_PATH}" \
    --transition-bezier .43,1.19,1,.4 \
    --transition-type "${xtrans}" \
    --transition-duration "${wallTransDuration}" \
    --transition-fps "${wallFramerate}" &
