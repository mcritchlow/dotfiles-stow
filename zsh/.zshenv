typeset -U path
# various bins
# path=(~/.local/share/nvim/plugged/fzf/bin ~/bin ~/.local/bin $path[@])

[[ $XDG_CONFIG_HOME ]] || export XDG_CONFIG_HOME="$HOME/.config"
export XDG_PICTURES_DIR="$HOME/Pictures"

# load Go
if test -d "$HOME/go"; then
  export GOPATH="$HOME/go"
  path=(~/go/bin $path[@])
fi

export WWW_HOME="https://duckduckgo.com"
export EDITOR="nvim"
export THOR_MERGE="nvim"
export VISUAL="nvim"
export BROWSER="chromium"
export TERMINAL="alacritty"
# Lastpass
export LPASS_PINENTRY="/usr/bin/pinentry-gnome3"
# don't allow agent to expire
export LPASS_AGENT_TIMEOUT=0
# Starlight config in an XDG_CONFIG_HOME directory instead of root
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship/config.toml"
# Bat theme (it defaults to a dark theme)
export BAT_THEME="GitHub"
