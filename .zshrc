#!/usr/bin/env bash

export ZDOTDIR=$HOME/.config/zsh

HISTFILE=~/.zsh_history
setopt appendhistory
export HISTORY_IGNORE=clear

# some useful options (man zshoptions)
setopt nomatch menucomplete
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

# completions
autoload -Uz compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
#
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

# Useful Functions
source "$ZDOTDIR/zsh-functions"

# Normal files to source
zsh_add_file "zsh-exports"
zsh_add_file "zsh-title"
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

# Key-bindings
bindkey "^i" up-line-or-beginning-search # Up
bindkey "^k" down-line-or-beginning-search # Down
bindkey "^l" forward-word
bindkey "^j" backward-word

bindkey "^u" expand-or-complete

clear_screen () {
  clear;
  zle reset-prompt
}
zle -N clear_screen
bindkey "^o" clear_screen

# FZF
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/doc/fzf/examples/completion.zsh ] && source /usr/share/doc/fzf/examples/completion.zsh
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f $ZDOTDIR/completion/_fnm ] && fpath+="$ZDOTDIR/completion/"

compinit

# Environment variables set everywhere
export EDITOR="nvim"
export TERMINAL="alacritty"
