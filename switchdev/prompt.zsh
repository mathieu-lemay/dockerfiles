# Color shortcuts {{{

let idx=0
let idx_bright=8
for color in black red green yellow blue magenta cyan white; do
    eval $color='${idx}'
    eval bright_$color='${idx_bright}'
    let idx=idx+1
    let idx_bright=idx_bright+1
done
unset idx idx_bright
color_reset="%f%k"

# }}}

printc() {
    if [ $# -gt 1 ]; then
        c="%F{${1}}"
        shift
    else
        c="%f"
    fi

    echo -n "${c}$1"
}

prompt_status() {
    local -a _status
    [[ $RETVAL -ne 0 ]] && _status+="(!) "

    [[ -n "${_status}" ]] && printc ${red} "${_status}"
}

prompt_host() {
    if [[ -n "$SSH_CLIENT" ]]; then
        fg="${yellow}"
    else
        fg="%(!.${red}.${green})"
    fi

    printc ${fg} "%n@%m"
}

prompt_dir() {
    printc ":"
    printc ${blue} "%1~"
}

prompt_end() {
    printc "$ "
}

build_ps1() {
    RETVAL=$?

    prompt_status
    prompt_host
    prompt_dir
    prompt_end
}

PS1='$(build_ps1)'
PS2='> '
RPROMPT=''
