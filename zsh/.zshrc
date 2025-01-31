# give us access to ^Q
stty -ixon

autoload -Uz compinit promptinit
compinit
promptinit

setopt promptsubst COMPLETE_ALIASES extendedglob hist_ignore_all_dups hist_ignore_space share_history

# we may not have fzf on silverblue host
[[ -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
[[ -f /usr/share/zsh/site-functions/fzf ]] && source /usr/share/zsh/site-functions/fzf

source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/functions
[[ -f ~/.config/zsh/functions.local ]] && source ~/.config/zsh/functions.local
source ~/.config/zsh/aliases
[[ -f ~/.config/zsh/aliases.local ]] && source ~/.config/zsh/aliases.local

# Set autosuggest highlight to be more visible
typeset -g ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# Set GPG TTY
# GPG_TTY=$(tty)
# export GPG_TTY
# Refresh gpg-agent tty in case user switches into an X session
# gpg-connect-agent updatestartuptty /bye >/dev/null

# autocompletion with an arrow-key driven interface
zstyle ':completion:*' menu select
# complete via sudo too
zstyle ':completion::complete:*' gain-privileges 1

# History
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# enable help alias for zsh
autoload -Uz run-help
unalias run-help
alias help=run-help

# vi mode
bindkey -v
export KEYTIMEOUT=1
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey '^F' fzf-cd-widget #override Alt-C (because DWM..)

# Per readme, source highlighting last since it wraps ZLE widgets
source ~/.config/zsh/theme-highlighting.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# for foot pipe-command-output
# see: https://codeberg.org/dnkl/foot/wiki#piping-last-command-s-output
# see: https://codeberg.org/dnkl/foot#piping-last-command-s-output
function precmd {
    if ! builtin zle; then
        print -n "\e]133;D\e\\"
    fi
}
function preexec {
    print -n "\e]133;C\e\\"
}

if command -v starship &> /dev/null
then
  eval "$(starship init zsh)"
fi
