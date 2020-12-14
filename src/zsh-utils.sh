# Git
alias gpfl="git push --force-with-lease"
gmo() {
    git fetch origin
    git merge "origin/$1"
}
gro() {
    git fetch origin
    git rebase "origin/$1"
}
switch() {
    branchName="Ayc0/$(echo $1 | sed -e 's/Ayc0\///')"
    if [[ $(git rev-parse --verify -q "$branchName" || false) ]]
    then
        git switch "$branchName"
    else
        echo "Creating new branch '$branchName'"
        git switch -c "$branchName"
    fi
}
alias tmp="git add . && git commit -m 'tmp' -n"

# Brew
alias bu="brew upgrade"
alias bcu="brew cask upgrade"

# Sweet utils
who-listen() {
    lsof -t -i :$1
}
kill-listening() {
    kill -9 $(who-listen $1)
}
time_ms() {
    ts=$(date +%s%N)
    $@
    echo "$((($(date +%s%N) - $ts)/1000000))ms"
}
# https://unix.stackexchange.com/questions/11856/sort-but-keep-header-line-at-the-top
body() {
    IFS= read -r header
    printf '%s\n' "$header"
    "$@"
}
set-personal-git() {
    git config user.name "Ayc0"
    git config user.email "ayc0.benj@gmail.com"
}
# https://gist.github.com/mplinuxgeek/dcbc3a4d0f51f2b445608e3da832ebb5
convert_gif() {
    # Usage function, displays valid arguments
    usage() {
    echo "Usage: $(basename ${0}) [arguments] inputfile [outputfile]" 1>&2
    echo "  -f  fps, defaults to 15" 1>&2
    echo "  -w  width, defaults to 480" 1>&2
    echo "  -d  dither level, value between 0 and 5, defaults to 5" 1>&2
    echo "                    0 is no dithering and large file" 1>&2
    echo "                    5 is maximum dithering and smaller file" 1>&2
    echo -e "\nExample: $(basename ${0}) -w 320 -f 10 -d 1" 1>&2
    exit 1
    }

    # Default variables
    fps=15
    width=480
    dither=5

    # getopts to process the command line arguments
    while getopts ":f:w:d:" opt; do
        case "${opt}" in
            f) fps=${OPTARG};;
            w) width=${OPTARG};;
            d) dither=${OPTARG};;
            *) usage;;
        esac
    done

    # shift out the arguments already processed with getopts
    shift "$((OPTIND - 1))"
    if (( $# == 0 )); then
        printf >&2 'Missing input file\n'
        usage >&2
    fi

    # set input variable to the first option after the arguments
    input="$1"

    # Extract filename from input file without the extension
    filename=$(basename "$input")
    #extension="${filename##*.}"
    filename="${filename%.*}.gif"
    filename="${2:-$filename}"

    # Debug display to show what the script is using as inputs
    echo "Input: ${1}"
    echo "Output: ${filename}"
    echo "FPS: ${fps}"
    echo "Width: ${width}"
    echo "Dither Level: ${dither}"

    # temporary file to store the first pass pallete
    palette="/tmp/palette.png"

    # options to pass to ffmpeg
    filters="fps=${fps},scale=${width}:-1:flags=lanczos"

    # ffmpeg first pass
    echo -ne "\nffmpeg 1st pass... "
    ffmpeg -v warning -i "${input}" -vf "${filters},palettegen=stats_mode=diff" -y "${palette}" && echo "done"

    # ffmpeg second pass
    echo -ne "ffmpeg 2nd pass... "
    ffmpeg -v warning -i "${input}" -i "${palette}" -lavfi "${filters} [x]; [x][1:v] paletteuse=dither=bayer:bayer_scale=${dither}" -y "${filename}" && echo "done"

    # display output file size
    filesize=$(du -h "${filename}" | cut -f1)
    echo -e "\nOutput File Name: ${filename}"
    echo "Output File Size: ${filesize}"
}
