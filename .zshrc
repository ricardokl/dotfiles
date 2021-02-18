# {{{ Exports
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim
export PAGER=/usr/bin/most
export TERM=alacritty
export PATH="$HOME/dotfiles/scripts:$HOME/bin:$PATH"
export HISTSIZE=1000
export SAVEHIST=1000
export HISTFILE="/home/ricardo/.zsh_history"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*" ~'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_C_COMMAND='fd --trype d ~ --hidden'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :50 {}'"
export FZF_CTRL_C_OPTS="--preview 'tree -C {} | head -50'"
# }}}

# {{{ Opções
bindkey -v

# compinit serve para o tab-completion do zsh
autoload -Uz compinit up-line-or-beginning-search down-line-or-beginning-search
compinit

zle -N up-line-or-beginning-search
zle -N down-line-or-beggining-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion::complete:*' gain-provileges 1
zstyle ':completion:*'  matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select
setopt AUTO_PUSHD
setopt PUSHD_SILENT
setopt AUTO_CD
setopt PUSHD_IGNORE_DUPS
setopt COMPLETE_ALIASES
# }}}

# {{{ Sourcing
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/fzf.plugin.zsh
# }}}

# {{{ Alias 1
alias vi='nvim'
alias commit='git commit -a'
alias push='git push'
alias l='lsd --group-dirs first -A'
alias ls='lsd --group-dirs first'
alias lt='lsd --group-dirs first --tree --depth 2'
alias alsa='alsamixer -c 0'
alias pacfzf="pacman -Slq | fzf -m --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
alias pacsyu="sudo pacman -Syu"
alias camera="echo 'gst-launch-1.0 souphttpsrc location=http://191.166.161.155:80/live ! jpegdec ! videoconvert ! v4l2sink device=/dev/video2' | xclip -selection clipboard"
alias ddgr='w3m www.duckduckgo.com'
alias keys="xev | awk -F'[ )]+' '/^KeyPress/ { a[NR+2] } NR in a { printf \"%-3s %s\n\", \$5, \$8 }'"
alias zet="nvim ~/zettel/'$(date +%Y-%m-%d-%H%M)'.md"
alias ze="~/zettel/'$(date +%Y-%m-%d-%H%M)'.md"
# alias trackpad='sudo rmmod i2c_hid && sleep 1 && sudo modprobe i2c_hid'
# }}}

# {{{ Alias 2 - programas
alias -s pdf=zathura
alias -s {vim,tex,md,py}=nvim
alias -s {docx,pptx,xlsx,ods}=libreoffice
alias -s {mp4,mkv,webm}=mpv
alias -s {JPG,jpg,jpeg}=gthumb
# }}}

# {{{ Alias 3 - Navegação
alias d='dirs -v | head -10'
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

eval "$(starship init zsh)"
