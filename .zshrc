# Path to your oh-my-zsh installation.
export ZSH="/home/$USER/.oh-my-zsh"

# ZSH_THEME="agnoster"
ZSH_THEME="muse"

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

plugins=(sudo python git chucknorris vi-mode fzf zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# {{{ Alias 1
alias pandoc='/usr/bin/pandoc'
alias vi='nvim'
alias nvrc='nvim ~/.config/nvim/init.vim'
alias zrc='nvim ~/.zshrc'
alias szrc='source ~/.zshrc'
alias snvrc='source ~/.config/nvim/init.vim'
alias commit='git commit -a'
alias push='git push'
alias l='ls -a'
# alias trackpad='sudo rmmod i2c_hid && sleep 1 && sudo modprobe i2c_hid'
alias s='systemctl --user restart pulseaudio'
# }}}

# {{{ Alias 2 - programas
alias -s pdf=zathura
alias -s {tex,md,py}=nvim
alias -s {docx,pptx,xlsx,ods}=libreoffice
alias -s {mp4,mkv,webm}=mpv
alias -s {JPG,jpg,jpeg}=viewnior
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
alias 9o='~/Documents/cap/9o2019/3otri/'
alias docs='~/Documents/'
# }}}

export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PAGER=/usr/bin/most

alias pacfzf="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

vman() {
	nvim +"Man $1 | only"
}

cl() {
	cd $1; ls -a
}

# {{{ Conda initialize
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
 __conda_setup="$('/home/teste/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
 if [ $? -eq 0 ]; then
     eval "$__conda_setup"
 else
     if [ -f "/home/teste/anaconda3/etc/profile.d/conda.sh" ]; then
         . "/home/teste/anaconda3/etc/profile.d/conda.sh"
     else
         export PATH="/home/teste/anaconda3/bin:$PATH"
     fi
 fi
 unset __conda_setup
# <<< conda initialize <<<
# }}}

prompt_context() { }
