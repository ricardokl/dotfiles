# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/ricardo/.oh-my-zsh"

ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
 ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

plugins=(sudo python git chucknorris vi-mode fzf zsh-autosuggestions zsh-syntax-highlighting) 

source $ZSH/oh-my-zsh.sh

alias vi='nvim'
alias nvrc='nvim ~/.config/nvim/init.vim'
alias zrc='nvim ~/.zshrc'
alias szrc='source ~/.zshrc'
alias snvrc='source ~/.config/nvim/init.vim'
alias docs='~/Documents/'
alias 9o='~/Documents/cap/9o2019/3otri/'
alias commit='git commit -a'
alias push='git push'
# alias trackpad='sudo rmmod i2c_hid && sleep 1 && sudo modprobe i2c_hid'

alias -s pdf=zathura
alias -s {tex,md,py}=nvim
alias -s {docx,pptx,xlsx,ods}=libreoffice
alias -s {mp4,mkv,webm}=mpv
alias -s {JPG,jpg,jpeg}=viewnior

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

alias pacfzf="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ricardo/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ricardo/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ricardo/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ricardo/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

prompt_context() { }
