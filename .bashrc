# This updates colors in function of ~/.dircolors
eval "`dircolors -b ~/.dircolors`"

# Useful on WSL
alias explorer='explorer.exe'

PS1='\e[94m\W \e[92m\$ \e[0m'

# some more ls aliases
alias ll='ls -AlF'
#alias ll="ls -lAG1 --color=always | grep -o \"[A-Z][a-z]\+[ ]*[0-9]\+.*\""
alias la='ls -A'
alias l='ls -CF'
