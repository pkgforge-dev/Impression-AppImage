#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q impression | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/io.gitlab.adhami3310.Impression.svg
export DESKTOP=/usr/share/applications/io.gitlab.adhami3310.Impression.desktop
export DEPLOY_OPENGL=1
export GTK_CLASS_FIX=1

# Trace and deploy all files and directories needed for the application (including binaries, libraries and others)
quick-sharun /usr/bin/impression \
             /usr/lib/libnss_mdns4_minimal.so*

# Turn AppDir into AppImage
quick-sharun --make-appimage
