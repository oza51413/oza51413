#!/usr/bin/bash

# 1. Enable RPM Fusion Free if you haven't already
# sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

# 2. Install the missing toolchain and decoders
# sudo dnf install libheif-tools libde265 x265
# sudo dnf install libheif-freeworld libheif-tools libavcodec-freeworld


for file in *.heic *.HEIC; do [ -f "$file" ] || continue; heif-convert -q 20 "$file" "${file%.*}.jpg"; done


