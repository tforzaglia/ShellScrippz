#customize command prompt
PS1="\\[$(tput setaf 2)\\]\\T\\[$(tput setaf 1)\\]:\\[$(tput bold ; tput setaf 3)\\]\\W"
PS1+="\$(prompt_git \"$(tput setaf 125) on branch $(tput setaf 166)\")" # git repository details
PS1+="\n$ \\[$(tput sgr0)\\]" # reset white
export PS1

#bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
	. $(brew --prefix)/etc/bash_completion
fi

#aliases
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

#show git branch in command prompt
prompt_git() {
    local s=""
    local branchName=""
    # check if the current directory is in a git repository
    if [ $(git rev-parse --is-inside-work-tree &>/dev/null; printf "%s" $?) == 0 ]; then
        branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
                      git rev-parse --short HEAD 2> /dev/null || \
                      printf "(unknown)")"
        [ -n "$s" ] && s=" [$s]"
        printf "%s" "$1$branchName$s"
    else
        return
    fi
}
