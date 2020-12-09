# {{{ Exports
# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PAGER=/usr/bin/most
export TERM=xterm-256color
export PATH="$HOME/bin:$PATH"
# }}}

# {{{ Config
ZSH_THEME="muse"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(sudo python chucknorris vi-mode fzf)
# }}}

# {{{ Sourcing
source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# }}}

xbindkeys

# {{{ Alias 1
alias vi='nvim'
alias commit='git commit -a'
alias push='git push'
alias l='lsd --group-dirs first -A'
alias ls='lsd --group-dirs first'
alias lt='lsd --group-dirs first --tree --depth 2'
alias a='alsamixer -c 0'
alias pacfzf="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias camera="echo 'gst-launch-1.0 souphttpsrc location=http://191.166.161.155:80/live ! jpegdec ! videoconvert ! v4l2sink device=/dev/video2' | xclip -selection clipboard"
# alias s='systemctl --user restart pulseaudio'
# alias trackpad='sudo rmmod i2c_hid && sleep 1 && sudo modprobe i2c_hid'
# }}}

# {{{ Alias 2 - programas
alias -s pdf=zathura
alias -s {vim,tex,md,py}=nvim
alias -s {docx,pptx,xlsx,ods}=onlyoffice
alias -s {mp4,mkv,webm}=mpv
alias -s {JPG,jpg,jpeg}=gthumb
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

prompt_context() { }
