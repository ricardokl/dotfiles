[[ -r ~/.config/zsh/znap/znap.zsh ]] || git clone --depth 1 -- \
http://github.com/marlonrichert/zsh-snap.git ~/.config/zsh/znap

bindkey -v

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^E' edit-command-line
zstyle :compinstall filename '/home/ricardo/.zshrc'
# export XDG_RUNTIME_DIR=/data/data/com.termux/files/usr/tmp

source ~/.config/zsh/znap/znap.zsh
znap source zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=( main brackets )
# znap source marlonrichert/zsh-edit
znap source zsh-users/zsh-history-substring-search
ZSH_AUTOSUGGEST_STRATEGY=( history )
znap source zsh-users/zsh-autosuggestions

znap eval zoxide 'zoxide init zsh'
znap eval starship 'starship init zsh --print-full-init'
if [ -n "$TERMUX_VERSION" ]; then
  znap eval mise 'mise activate zsh'
fi
znap prompt

znap function _pip_completion pip 'eval "$(pip completion --zsh)"'
compctl -K _pip_completion pip

# bindkey '^[[A' up-line-or-history
# bindkey '^[[B' down-line-or-history
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
source $HOME/.config/zsh/fzf.zsh

# if [ -n "$TERMUX_VERSION" ]; then
#   source /data/data/com.termux/files/home/.config/zsh/fzf.zsh
# else
#   source /home/ricardo/.config/zsh/fzf.zsh
# fi
# Use fd to generate the list for directory completion
znap function _fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --color=always . "$1"
}
# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
znap function _fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --color=always . "$1"
}

# {{{ Options section
setopt correct
setopt extendedglob nocaseglob numericglobsort
setopt nobeep nocheckjobs
setopt autocd auto_pushd pushd_silent
setopt inc_append_history appendhistory histignorealldups
setopt complete_aliases rcexpandparam braceexpand

# zstyle '*:compinit' arguments -D -i -u -C -w
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for di>
zstyle ':completion:*' rehash true                              # automatically find new executables in path
zstyle ':completion:*' menu select
zstyle ':completion:complete:*' gain-privileges 1
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=10000
SAVEHIST=10000
# WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of t>
# }}}

# {{{ Theming section
# autoload -U compinit colors zcalc
# compinit -d
# colors
# }}}

# {{{ Alias Section
alias cp="cp -i"                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias vi='nvim'
alias l='lsd --group-dirs first -Al'
alias la='lsd --group-dirs first -A'
alias ll='lsd --group-dirs first -l'
alias ls='lsd --group-dirs first'
alias lt='lsd --group-dirs first --tree --depth=2'
alias aider='aider --config /home/ricardo/.config/aider/conf.yaml'
alias aider_architect='aider --config /home/ricardo/.config/aider/config.yaml --architect'
alias rovo='acli rovodev run'

alias yt='yt-dlp --paths /data/data/com.termux/files/home/storage/movies/ "$(termux-clipboard-get)"'
# }}}

# {{{ Navegação
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



# . "$HOME/.local/share/../bin/env"

# opencode
export PATH=/home/ricardo/.opencode/bin:$PATH
