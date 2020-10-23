# {{{ Exports
# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PAGER=/usr/bin/most
# export TERM=xterm
# }}}

# {{{ Config
ZSH_THEME="muse"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(sudo python git chucknorris vi-mode fzf)
# }}}

# {{{ Alias 1
alias vi='nvim'
alias commit='git commit -a'
alias push='git push'
alias l='ls -a'
alias s='systemctl --user restart pulseaudio'
alias a='alsamixer -c 0'
alias pacfzf="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
# alias trackpad='sudo rmmod i2c_hid && sleep 1 && sudo modprobe i2c_hid'
# }}}

# {{{ Alias 2 - programas
alias -s pdf=zathura
alias -s {tex,md,py}=nvim
alias -s {docx,pptx,xlsx,ods}=libreoffice
alias -s {mp4,mkv,webm}=mpv
# alias -s {JPG,jpg,jpeg}=viewnior
# }}}

# {{{ Alias 3 - Navegação
alias d='dirs -v |head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
# }}}

# {{{ Sourcing
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# }}}

xbindkeys

prompt_context() { }
