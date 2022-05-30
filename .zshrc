#!/usr/bin/env zsh

########################################
# powerlevel10k instant prompt
########################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################################
# config files
########################################

for file in ~/.{aliases,exports,functions}; do
	if [[ -r "$file" ]]; then
   source "$file"
  fi
done;
unset file;

########################################
# vi mode
########################################

# use vi mode in zsh line editor
bindkey -v 

########################################
# general options
########################################

# # don't beep on errors in zsh line editor
setopt NO_BEEP

########################################
# history
########################################

# set the path to the file where history is saved
HISTFILE=~/.zsh_history
# set number of commands stored in zsh history file (1 billion)
SAVEHIST=1000000000
# set number of commands loaded into memory from zsh history file (1 billion)
HISTSIZE=1000000000
# incrementally append to history while the shell is running it instead of on shell close
setopt INC_APPEND_HISTORY
# include command start time and duration in history
setopt EXTENDED_HISTORY
# don't include commands in history if they start with a space
setopt HIST_IGNORE_SPACE
# don't beep in zsh line editor when we attempt to access non-existent history
setopt NO_HISTBEEP
# when you use bang-history (!!) print the substitution before executing
setopt HIST_VERIFY

########################################
# zinit setup
########################################

# load zinit (cloned in bootstrap)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# disabled because it overwrites mcfly ctrl-r
########################################
# zsh-vi-mode
########################################

function zvm_after_init() {
  # use mcfly to search history
  zvm_bindkey viins '^R' mcfly-history-widget
}

zinit ice depth=1 wait lucid 
zinit light jeffreytse/zsh-vi-mode

# enables ctrl-p ctrl-n for next/previous history
# enables surround plugin
# enables ctrl-a and ctrl-x to increment and decrement numbers, booleans, dates

########################################
# powerlevel10k
########################################

zinit ice depth=1
zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################################
# zsh-autosuggestions
########################################

zinit ice depth=1 wait"!" lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

########################################
# zsh-completions
########################################

zinit ice depth=1 wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# really cool but doesn't seem to play well with vscode's terminal
# ########################################
# # zsh-autocomplete
# ########################################

# zinit ice depth=1 wait lucid blockf atpull'zinit creinstall -q .'
# zinit light marlonrichert/zsh-autocomplete

########################################
# zsh-syntax-highlighting
########################################

# zsh syntax highlighting must be added last

# when syntax highlighting is performed we call compinit and replay
# any completion definiitons
zinit ice depth=1 wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zsh-users/zsh-syntax-highlighting

########################################
# zsh-history-substring-search
########################################

# this is the only exception. substring search can be added after zsh-syntax-highlighting

zinit ice depth=1 wait lucid atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down;"
zinit light zsh-users/zsh-history-substring-search

########################################
# zoxide
########################################

zinit ice depth=1 wait lucid atinit'eval "$(zoxide init zsh)"'
zinit light zdharma-continuum/null

# save up to 1 billion entries in zoxide database
export _ZO_MAXAGE=1000000000

########################################
# mcfly
########################################

zinit ice depth=1 wait lucid atinit'eval "$(mcfly init zsh)"'
zinit light zdharma-continuum/null

# use vim keys for mcfly
export MCFLY_KEY_SCHEME=vim
# enable fuzzy search in mcfly
export MCFLY_FUZZY=2
# save up to 1 billion entries in mcfly database
export MCFLY_HISTORY_LIMIT=1000000000

