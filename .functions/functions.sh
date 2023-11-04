#!/bin/zsh

source $HOME/.functions/general.sh
source $HOME/.functions/functions_local.sh 2>/dev/null || true

to_xclip() {
    echo "Copying $@ to clipboard"
    cat "$@" | xcopy
}


count() {
    ls -1 $1 | wc -l
}


ssh-keygen-now() {
    ssh-keygen -t rsa -b 4096
}

replace_text() {
    from="$1"
    to="$2"

    files=$(ag $from -l --hidden --ignore ".git")
    files_count=$(echo $files | wc -l)
    
    if [[ $files == "" ]]; then
        echo "No recurrences in any file"
        return 
    fi

    echo "Replace in $files_count file(s)"

    echo ""
    ag $from --hidden  --ignore ".git"
    echo ""

    if [[ $(ask_yes_no "Replace all") == true ]]; then
        for file in $(echo $files); do
            sed -i "s/$from/$to/g" $file
        done
    fi
 }

MP4_to_MOV() {
    mp4_path=${1}
    mov_path=${2}
    ffmpeg -i $mp4_path \
        -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p \
        -c:a pcm_s16le \
        -f mov $mov_path
}

poetry_activate() {
    path_env=$(poetry env list --full-path)
    result=$?

    if [[ $result != 0 ]]; then
        echo "Aborting."
        return $result
    fi


    if [[ $path_env =~ "Activate" ]]; then
        path_env=$(echo $path_env | grep Activated | cut -d' ' -f1 )
        result=$?

        if [[ $result != 0 ]]; then
            echo "Aborting."
            return $result
        fi
    fi

    if [ -d "$path_env" ]; then
        source "$path_env/bin/activate"
        return 0
    else
        echo "Could not activate the environment."
        return 1
    fi
}
