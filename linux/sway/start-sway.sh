#!/bin/bash
#
# Set ENV variables and start sway
#
# NOTE: some stuff might be in /etc/sway/config.d/50-systemd-user.conf
# 
# Call this as such:
# File: /usr/share/wayland-sessions/sway.desktop
# ----------------------------------------------
# [Desktop Entry]
# Name=Sway
# Comment=An i3-compatible Wayland compositor
# Exec=~/.config/sway/start-sway.sh --unsupported-gpu
# Type=Application


#
# Set ENV
#
# Generally speaking, Hyprland documentation has some pretty good info
#  - https://wiki.hyprland.org/Configuring/Environment-variables/
#

# idk why this here
#export PATH=$PATH:$scrPath


#
# XDG or fd.o - Freedesktop.org
#   - used by X11 and Wayland
#   - supported/contributed by GNOME and KDE
#
# This sh!t doesn't seem to be documented in any one place:
#   - https://en.wikipedia.org/wiki/Freedesktop.org
#   - https://wiki.archlinux.org/title/Category:Freedesktop.org
#   - https://specifications.freedesktop.org/basedir-spec/latest/ar01s03.html
#   - https://www.freedesktop.org/software/systemd/man/latest/pam_systemd.html#Environment
#
# Some of these might be redundant with those set by sway automatically 
#   - See: /etc/sway/config.d/50-systemd-user.conf
export XDG_CURRENT_DESKTOP=sway # colon separated list of strings that the current desktop environment identifies as.
export XDG_SESSION_DESKTOP=sway # similar to XDG_CURRENT_DESKTOP, but only permits a single string. 
export XDG_SESSION_TYPE=wayland # One of "unspecified", "tty", "x11", "wayland" or "mir".


#
# GDK / GTK / GUI stuff
#
# See:
#   - https://wiki.archlinux.org/title/HiDPI
export GDK_SCALE=1 # Used by many apps (GTK, Java, Steam, etc.) to set HiDPI scaling, along with GDK_DPI_SCALE


#
# QT Framework
#  - cross-platform sdk, used largely by KDE
#
# Env vars also not collectively documented afaik.
#   - https://doc.qt.io/
#
#export QT_QPA_PLATFORM=wayland;xcb
export QT_STYLE_OVERRIDE=kvantum
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1


#
# NVidia / GPU stuff
#
# See:
# - https://wiki.archlinux.org/title/PRIME
# - https://download.nvidia.com/XFree86/Linux-x86_64/550.54.14/README/primerenderoffload.html
#

# Mesa
# the below causes crashes in Firefox under hardware acceleration
# export GBM_BACKEND=nvidia-drm # force GBA backend for Wayland - https://en.wikipedia.org/wiki/Mesa_(computer_graphics)#Generic_Buffer_Management

# OpenGL
export __GLX_VENDOR_LIBRARY_NAME=nvidia # X = X11?
export __GL_VRR_ALLOWED=0 # whether Variable Refresh Rate (adaptive sync) is allowed -- only works for OpenGL and not Vulkan?? Hyprland recommend set 0 to disable
#export __GL_THREADED_OPTIMIZATIONS=0 # disables threading optimizations -- specific for Minecraf

# Video Acceleration API - libva / va-api / vdpau
#   - https://wiki.archlinux.org/title/Hardware_video_acceleration
export LIBVA_DRIVER_NAME=nvidia


#
# wlroots / Wayland stuff
#
# See:
#   - https://github.com/swaywm/wlroots/blob/master/docs/env_vars.md
export WLR_DRM_NO_ATOMIC=1 # use legacy DRM interface instead of atomic mode setting. Might fix flickering issues.
export WLR_NO_HARDWARE_CURSORS=1


#
# SDL stuff
#
# See:
#   - https://wiki.libsdl.org/SDL2/FAQUsingSDL
export SDL_VIDEODRIVER=wayland
# TODO: Not sure what to do for SDL3.

#
# Misc. application stuff
#
#

# Starting with version 121, Firefox defaults to Wayland instead of XWayland and does not require any configuration
# look for Window Protocol in about:support. It should say wayland
# export MOZ_ENABLE_WAYLAND=1

# just bc
export BERTS_IN_DA_HOUSE="yes-he-is"


#
# Start sway
#
exec sway --unsupported-gpu
