typeset -U PATH

# PREFIX="/usr"

# Set paths using PREFIX variable
XDG_RUNTIME_DIR="$PREFIX/usr/tmp"
EDITOR="$PREFIX/bin/nvim"
VISUAL="$PREFIX/bin/nvim"
PAGER="$PREFIX/bin/most"
BAT_PAGER="$PREFIX/bin/most"
XDG_RUNTIME_DIR="$PREFIX/tmp/"

export EDITOR VISUAL PAGER BAT_PAGER

# Common settings for both environments
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export PYTHONSTARTUP="$(python -m jedi repl)"
export FZF_DEFAULT_OPTS="--ansi"
export ZDOTDIR=$HOME/.config/zsh

# Source API keys if file exists
[[ -f $HOME/api ]] && source $HOME/api
