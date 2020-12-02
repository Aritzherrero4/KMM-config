# Check programs
if [ -z "$(which ffmpeg)" ]; then
    echo "Error: ffmpeg is not installed"
    exit 1
fi


f=$(basename "$1") # fullname of the file
f="${f%.*}" # name without extension

  if [ ! -d "dash_${f}" ]; then
    echo "Converting \"$f\" to multi-bitrate video in MPEG-DASH"

    ffmpeg -y -i "${f}.mp4" -c:a libfdk_aac -ac 2 -ab 128k -vn "${f}_audio.m4a"

    ffmpeg -y -i "${f}.mp4" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 1500k -vf "scale=-2:720" -f mp4 -pass 1 -y /dev/null
    ffmpeg -y -i "${f}.mp4" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 1500k -vf "scale=-2:720" -f mp4 -pass 2 "${f}_1500.mp4"

    ffmpeg -y -i "${f}.mp4" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 800k -vf "scale=-2:540" -f mp4 -pass 1 -y /dev/null
    ffmpeg -y -i "${f}.mp4" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 800k -vf "scale=-2:540" -f mp4 -pass 2 "${f}_800.mp4"

    ffmpeg -y -i "${f}.mp4" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 400k -vf "scale=-2:360" -f mp4 -pass 1 -y /dev/null
    ffmpeg -y -i "${f}.mp4" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 400k -vf "scale=-2:360" -f mp4 -pass 2 "${f}_400.mp4"

    ffmpeg -y -i "${f}.mp4" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 200k -vf "scale=-2:180" -f mp4 -pass 1 -y /dev/null
    ffmpeg -y -i "${f}.mp4" -an -c:v libx264 -x264opts 'keyint=24:min-keyint=24:no-scenecut' -b:v 200k -vf "scale=-2:180" -f mp4 -pass 2 "${f}_200.mp4"

    rm -f ffmpeg*log*

    MP4Box -dash 2000 -rap -frag-rap -profile onDemand "${f}_1500.mp4" "${f}_800.mp4" "${f}_400.mp4" "${f}_200.mp4" "${f}_audio.m4a" -out "${f}_MP4.mpd"


    rm  "${f}_1500.mp4" "${f}_800.mp4" "${f}_400.mp4" "${f}_200.mp4" "${f}_audio.m4a"
fi

