#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q impression | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/io.gitlab.adhami3310.Impression.svg
export DESKTOP=/usr/share/applications/io.gitlab.adhami3310.Impression.desktop
export DEPLOY_OPENGL=1
export STARTUPWMCLASS=impression # For Wayland, this is 'io.gitlab.adhami3310.Impression', so this needs to be changed in desktop file manually by the user in that case until some potential automatic fix exists for this

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/impression \
             /usr/lib/libnss_mdns4_minimal.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage
