# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

ID_EPITA='erwan.vivien'

# This updates colors in function of ~/.dircolors
eval "`dircolors -b ~/.dircolors`"

alias dev='cd /mnt/d/dev/'
alias explorer='explorer.exe'
alias git_url='git config --get remote.origin.url'
alias python='python3'
alias py='python3'
# alias gcc='gcc -Wextra -Werror -Wall -std=c99 -pedantic -Wstrict-prototypes'
alias gdb='gdb -q'

alias ..="source ~/.bashrc"
alias cl="clang-format"

# USEFUL FUNCTIONS ==============

gccf()
{
    if [[ $* == *"-"* ]]; then
        gcc $*;
    else
        gcc -Wextra -Werror -Wall -std=c99 -pedantic -Wstrict-prototypes $*
    fi
}
export -f gccf

notepad() {
    '/mnt/c/Program files (x86)/Notepad++/notepad++.exe' $@ & disown
}
export -f notepad

saveBash() {
    cp  ~/.vimrc /mnt/d/unix_cpy/
    cp  ~/.bashrc /mnt/d/unix_cpy/
    cp  ~/.dircolors /mnt/d/unix_cpy/
    cp  ~/.setup /mnt/d/unix_cpy/
    cp  ~/.default.* /mnt/d/unix_cpy/
}

mBash() {
    vim ~/.bashrc    
    .   ~/.bashrc
    saveBash
}
export -f mBash

# START GOTO ====================

GO() {
    tmp=""
    if [[ -z $1 ]]; then
        tmp=$(ls -va1 --color=none | tail -1)
#        tmp=${tmp:2:2}
    else
        tmp=$1
        if [[ ${#tmp} -eq 1 ]]; then
            tmp=tp0$tmp-$ID_EPITA
        else
            tmp=tp$tmp-$ID_EPITA
        fi
    fi  
    cd $tmp
}

GO_TP() {
    if [[ "$#" -eq 0 ]]; then
        GO; GO
        cd p*
    elif [[ "$#" -eq 1 ]]; then
        fl=$(echo $1 | head -c 1)
        if [[ $fl == "s" ]]; then
            [[ ! -d $1 ]] && mkdir $1 ||cd $1
        else 
            GO
            GO $1
            cd p*
        fi
    elif [[ "$#" -eq 2 ]]; then
        fl=$(echo $1 | head -c 1)
        if [[ $fl == "s" ]]; then
            cd $1
            GO $2
        else 
            cd $2
            GO $1
        fi
        cd p*
    else
        echo bad usage.
    fi
}

c() {
    cd /mnt/d/dev/c/tps/
    GO_TP $@
}
export -f c 

createC() {

    for arg in $*; do
        if ! [[ -f $arg ]]; then
            cp ~/.default.c ./$arg;
        fi
    done

    if ! [[ -f "./Makefile" ]]; then
        cp ~/.default.make ./Makefile;
    fi

    vim $1
}
export -f createC


r() {
    cd /mnt/d/dev/rust/tps/
    GO_TP $@
}
export -f r

# END GOTO ======================

CLONE()
{
    tp=""
    if [[ -z $1 ]]; then
        tp=$(ls -va1 --color=none | tail -1)
        echo $tp 1
        tp=${tp:2:2}
        echo $tp 1

        if [[ ${tp::1} == "0" ]]; then
            tp=tp0$(( ${tp:1:1} + 1 ))-$ID_EPITA
        else
            tp=tp$(( $tp + 1 ))-$ID_EPITA
        fi
        echo $tp 1
    else
        tp=$1
        if [[ ${#tp} -eq 1 ]]; then
            tp=tp0$tp-$ID_EPITA
        else
            tp=tp$tp-$ID_EPITA
        fi
        echo $tp 2
    fi  
    git clone git@git.cri.epita.net:p/2023-$( basename "$PWD" )-tp/$tp
    cd $tp
    mkdir pw
    echo -e "Erwan\nVivien\nerwan.vivien\nerwan.vivien@epita.fr" >> pw/AUTHORS
    # End
    echo "Rename pw directory"
}

CLONE_TP()
{
    if [[ "$#" -eq 0 ]]; then
        GO; 
        CLONE
    elif [[ "$#" -eq 1 ]]; then
        fl=$(echo $1 | head -c 1)
        if [[ $fl == "s" ]]; then
            [[ ! -d $1 ]] && mkdir $1 ||cd $1
        else 
            cd $1
            CLONE
        fi
    elif [[ "$#" -eq 2 ]]; then
        fl=$(echo $1 | head -c 1)
        if [[ $fl == "s" ]]; then
            cd $1
            CLONE $2
        else 
            cd $2
            CLONE $1
        fi
        cd p*
    else
        echo bad usage.
    fi
}

cclone()
{
    cd /mnt/d/dev/c/tps/
    CLONE_TP $@
}

rclone()
{
    cd /mnt/d/dev/rust/tps/
    CLONE_TP $@
}
 

rclean()
{
    for arg in $(ls -d */)
    do
        cd $arg
        cargo clean
        echo cleaned $arg
        cd ..
    done
}











# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\e[94m\W \e[92m\$ \e[0m'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -AlF'
#alias ll="ls -lAG1 --color=always | grep -o \"[A-Z][a-z]\+[ ]*[0-9]\+.*\""
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#GOPATH=$HOME/go
#function _update_ps1() {
#    PS1="$($GOPATH/bin/powerline-go -error $?)"
#}
#if [ "$TERM" != "linux" ] && [ -f "$GOPATH/bin/powerline-go" ]; then
#    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
#fi
