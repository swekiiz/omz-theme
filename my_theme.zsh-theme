typeset -g -A host_repr

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="blue"; fi

host_repr=('dieter-ws-a7n8x-arch' "%{$fg_bold[green]%}ws" 'dieter-p4sci-arch' "%{$fg_bold[blue]%}p4")

time_enabled="%(?.%{$fg[green]%}.%{$fg[red]%})%*%{$reset_color%}"
time_disabled="%{$fg[green]%}%*%{$reset_color%}"
time=$time_enabled

local user="%(!.%{$fg[$NCOLOR]%}.%{$fg[$NCOLOR]%})%n%{$reset_color%}"

local host="%{$fg[cyan]%}@${host_repr[$HOST]:-$HOST}%{$reset_color%}"

local pwd="%{$fg[magenta]%}%~%{$reset_color%}"

local suffix=" %{$fg[red]%}%(!.#.»)%{$reset_color%} "

PROMPT='${time}•${user}${host} ${pwd}$(git_prompt_info)${suffix}'
PROMPT2='${time} %{$fg[red]%}\ %{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%} ("
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%} ⚡%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ○%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg[yellow]%})%{$reset_color%}"

# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ○%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭%{$reset_color%}"

return_code_enabled="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
return_code_disabled=
return_code=$return_code_enabled

RPS1='${return_code}'

function accept-line-or-clear-warning() {
    if [[ -z $BUFFER ]]; then
        time=$time_disabled
        return_code=$return_code_disabled
    else
        time=$time_enabled
        return_code=$return_code_enabled
    fi
    zle accept-line
}

zle -N accept-line-or-clear-warning
bindkey '^M' accept-line-or-clear-warning
