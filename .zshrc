#!/usr/bin/env zsh

########################################
# fig pre block
########################################

. "$HOME/.fig/shell/zshrc.pre.zsh"

########################################
# Aliases
########################################

# source zshrc
alias zource="source ~/.zshrc"

# use lsd instead of ls
alias ls='lsd'

# use bat instead of cat
alias cat='bat'

# add kitty shell integration when using ssh to remote hosts
alias ssh='kitty +kitten ssh'

########################################
# exports
########################################

# make code the default editor
export EDITOR="code"

# Make Python use UTF-8 encoding for output to stdin, stdout, and stderr.
export PYTHONIOENCODING='UTF-8'

# Prefer US English and use UTF-8.
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
export GPG_TTY=$(tty)

# automatically start tmux
export ZSH_TMUX_AUTOSTART="false"
# don't quit the terminal when we leave tmux
export ZSH_TMUX_AUTOQUIT="false"
# fix the TERM variable automatically
export ZSH_TMUX_FIXTERM="true"

# don't check node js signatures
export NODEJS_CHECK_SIGNATURES="no"

# add sbin to path (homebrew)
export PATH="/usr/local/sbin:$PATH"

########################################
# functions
########################################

# clone a git url to a specific path
clone() {
    if (($# != 1)); then
        echo "usage: clone() giturl"
        return 1
    fi
    # extract repo name and hostname from giturl
    local url=$1:l
    local url_without_suffix="${url%\.git}"
    local reponame=$(basename "$url_without_suffix")
    local hostname=$(basename "${url_without_suffix%/"${reponame}"}")
    local hostname=${hostname#*:}

    GITHUB_ROOT=~/Documents/repos/github

    # mkdir and clone if it does not exist
    mkdir -p "$GITHUB_ROOT/$hostname/"
    [ -d "$GITHUB_ROOT/$hostname/$reponame" ] || git clone "$url" "$GITHUB_ROOT/$hostname/$reponame"
    echo_ok "go get to work"
    echo_ok "cd $GITHUB_ROOT/$hostname/$reponame"
    echo "cd $GITHUB_ROOT/$hostname/$reponame" | pbcopy
}

heart() {
    # get the song status as a string and check if the command succeeded
    local song_status
    song_status="$(spt playback -s)"
    song_status_succeded=$?
    if [[ $song_status_succeded == 0 ]]; then
        # if song status starts with `liked`
        if [[ $song_status == liked* ]]; then
            echo "Already hearted"
        else
            spt playback --like >/dev/null && echo "Hearted" || echo "spt error"
        fi
    else
        echo "spt error"
    fi
}

unheart() {
    # get the song status as a string and check if the command succeeded
    local song_status
    song_status="$(spt playback -s)"
    song_status_succeded=$?
    if [[ $song_status_succeded == 0 ]]; then
        # if song status starts with `liked`
        if [[ $song_status == liked* ]]; then
            spt playback --dislike >/dev/null && echo "Unhearted" || echo "spt error"
        else
            echo "Already unhearted"
        fi
    else
        echo "spt error"
    fi
}


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

# set up options to save zsh history
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

# start zinit
########################################

# load zinit (cloned in bootstrap)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

# disabled because it overwrites mcfly ctrl-r
########################################
# zsh-vi-mode
########################################

function zvm_after_init() {
  # zsh-vi-mode calls this function after init.
  # you can use this function to override zsh-vi-mode keybindings

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

# provides a sexy and configurable prompt
########################################

zinit ice depth=1
zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################################
# zsh-autosuggestions

# suggests commands as you type based on history and completions
########################################

zinit ice depth=1 wait"!" lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

########################################
# zsh-syntax-highlighting

# add syntax highlighting to the shell
########################################

# zsh syntax highlighting must be added last

# when syntax highlighting is performed we call compinit and replay
# any completion definiitons
zinit ice depth=1 wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zsh-users/zsh-syntax-highlighting

########################################
# zsh-history-substring-search

# up-down arrow search history using current prompt as prefix
########################################

# this is the only exception. substring search can be added after zsh-syntax-highlighting

zinit ice depth=1 wait lucid atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down;"
zinit light zsh-users/zsh-history-substring-search

########################################
# zoxide

# enables jumping to directories using z
########################################

zinit ice depth=1 wait lucid atinit'eval "$(zoxide init zsh)"'
zinit light zdharma-continuum/null

# save up to 1 billion entries in zoxide database
export _ZO_MAXAGE=1000000000

########################################
# mcfly

# ctrl-r history search using a neural network
########################################

zinit ice depth=1 wait lucid atinit'eval "$(mcfly init zsh)"'
zinit light zdharma-continuum/null

# use vim keys for mcfly
export MCFLY_KEY_SCHEME=vim
# enable fuzzy search in mcfly
export MCFLY_FUZZY=2
# save up to 1 billion entries in mcfly database
export MCFLY_HISTORY_LIMIT=1000000000

########################################
# fig post block
########################################

. "$HOME/.fig/shell/zshrc.post.zsh"