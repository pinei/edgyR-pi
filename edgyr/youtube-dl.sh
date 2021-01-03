#! /bin/bash

set -e

# https://ytdl-org.github.io/youtube-dl/download.html
# https://github.blog/2020-11-16-standing-up-for-developers-youtube-dl-is-back/
echo "Installing 'youtube-dl' from upstream binary"
wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
chmod +x /usr/local/bin/youtube-dl
