#!/bin/bash


latest_version=$(curl -s https://api.github.com/repos/yt-dlp/yt-dlp/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')


download_link="https://github.com/yt-dlp/yt-dlp/releases/download/${latest_version}/yt-dlp_linux"


wget ${download_link} -O yt-dlp
chmod +x yt-dlp
read -p "Livestream or video? (Type 'livestream' or 'video'): " lst
read -p "Enter YouTube URL: " url
if [ "$lst" == "livestream" ]; then
  ./yt-dlp --list-formats "$url"
  read -p "Enter format number: " number
  ./yt-dlp -f "$number" -g "$url"
elif [ "$lst" == "video" ]; then
  ./yt-dlp "$url"
    read -p "Would you like your video converted to MP3? (yes/no) " mp3
    if [ "$mp3" == "yes" ]; then

        filename=$(./yt-dlp -i --get-filename --skip-download $url)
        onnih="$filename.mp3"

        ffmpeg -i "$filename" -vn -ab 192k -acodec libmp3lame -ac 2 "$onnih"
      fi
fi
rm yt-dlp
exit
