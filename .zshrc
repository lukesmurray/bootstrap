#!/usr/bin/env zsh

########################################
# fig pre block
########################################

. "$HOME/.fig/shell/zshrc.pre.zsh"

########################################
# Bash completion compatability
########################################

autoload -U bashcompinit
bashcompinit

########################################
# Aliases
########################################

# source zshrc
alias zource="source ~/.zshrc"

# use lsd instead of ls
alias ls='lsd'

# use bat instead of cat
alias cat='bat'

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
    cd $GITHUB_ROOT/$hostname/$reponame
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

update_tools() {
    # update brewfiles
    brew bundle --global install;

    # update asdf pluings
    asdf plugin update --all;

    # update zinit
    zinit self-update;
    # update zinit plugins and snippets
    zinit update --all;
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

# zsh-vi-mode calls this function after init.
# you can use this function to override zsh-vi-mode keybindings
function zvm_after_init() {
  # bind ctrl-r to search history with mcfly
  zvm_bindkey viins '^R' mcfly-history-widget
  zvm_bindkey vicmd '^R' mcfly-history-widget
  # bind ctrl+alt+r to search history with fzf
  zvm_bindkey viins '^[^R' fzf-history-widget
  zvm_bindkey vicmd '^[^R'  fzf-history-widget
}

zinit ice depth=1 wait lucid 
zinit load jeffreytse/zsh-vi-mode

# enables ctrl-p ctrl-n for next/previous history
# enables surround plugin
# enables ctrl-a and ctrl-x to increment and decrement numbers, booleans, dates

########################################
# powerlevel10k

# provides a sexy and configurable prompt
########################################

zinit ice depth=1
zinit load romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################################
# zsh-autosuggestions

# suggests commands as you type based on history and completions
########################################

zinit ice depth=1 wait"!" lucid atload"_zsh_autosuggest_start"
zinit load zsh-users/zsh-autosuggestions

########################################
# oh my zsh plugins
########################################

# add all the git aliases
zinit ice depth=1 wait lucid blockf
zinit snippet OMZP::git

# press escape key twice after a command fails to run becaus of sudo
# the command will reappear prefixed by sudo
zinit ice depth=1 wait lucid blockf
zinit snippet OMZP::sudo

# load ssh-agent in quiet mode
zstyle :omz:plugins:ssh-agent quiet yes

# start ssh-agent
zinit ice depth=1 wait lucid blockf
zinit snippet OMZP::ssh-agent

########################################
# zsh-completions
########################################

zinit ice depth=1 wait lucid blockf atpull'zinit creinstall -q .'
zinit load zsh-users/zsh-completions

########################################
# zoxide

# enables jumping to directories using z
########################################

zinit ice depth=1 wait lucid atinit'eval "$(zoxide init zsh)"'
zinit load zdharma-continuum/null

# save up to 1 billion entries in zoxide database
export _ZO_MAXAGE=1000000000

########################################
# mcfly

# ctrl-r history search using a neural network
########################################

zinit ice depth=1 wait lucid atinit'eval "$(mcfly init zsh)"'
zinit load zdharma-continuum/null

# use vim keys for mcfly
export MCFLY_KEY_SCHEME=vim
# enable fuzzy search in mcfly
export MCFLY_FUZZY=2
# save up to 1 billion entries in mcfly database
export MCFLY_HISTORY_LIMIT=1000000000

########################################
# direnv

# load and unload environments based on the current directory
########################################

zinit ice depth=1 wait lucid atinit'eval "$(direnv hook zsh)"'
zinit load zdharma-continuum/null

########################################
# duti

# set default applications for file types
########################################

zinit ice depth=1 wait lucid atinit'duti $HOME/.duti'
zinit load zdharma-continuum/null

########################################
# fzf

# fzf provides completions and fuzzy finding for zsh
########################################

# Set fd as the default source for bare fzf commands. Respects gitignore.
export FZF_DEFAULT_COMMAND='fd --type f'

# Set fd as the default source for ctrl + t commands. Respects gitignore.
export FZF_CTRL_T_COMMAND='fd --type f'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_setup_fzf() {
    # Setup fzf
    # ---------
    if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
        export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
    fi

    # Auto-completion
    # ---------------
    [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

    # Key bindings
    # ------------
    source "/usr/local/opt/fzf/shell/key-bindings.zsh"
}

zinit ice depth=1 wait lucid atinit'_setup_fzf; unfunction _setup_fzf'
zinit load zdharma-continuum/null

########################################
# asdf

# manage multiple runtime versions with a single cli tool
########################################

_setup_asdf() {
    # setup asdf hook
    . $(brew --prefix asdf)/libexec/asdf.sh;

    # list of asdf plugins to install
    plugin_list=('direnv' 'nodejs' 'python')

    # currently installed plugins (list of plugins separated by newlines)
    currently_installed_plugins=$(asdf plugin list)

    for plugin in $plugin_list; do

        # if the plugin is not in the currently installed plugins list, install it
        if ! echo "$currently_installed_plugins" | rg -q "$plugin"; then
            echo "installing asdf plugin $plugin"
            asdf plugin add $plugin > /dev/null 2>&1;

            # asdf-direnv hook post-install step
            if [[ $plugin = 'direnv' ]] ; then
                asdf direnv setup --shell zsh --version system
                echo "remember to clean up your zshrc"
            fi
        fi
    done

    # setup asdf-direnv hook
    source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
}

zinit ice depth=1 wait lucid atinit'_setup_asdf; unfunction _setup_asdf'
zinit load zdharma-continuum/null

########################################
# zsh-syntax-highlighting

# add syntax highlighting to the shell
########################################

# zsh syntax highlighting must be added last

# when syntax highlighting is performed we call compinit and replay
# any completion definiitons
zinit ice depth=1 wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit load zsh-users/zsh-syntax-highlighting

########################################
# zsh-history-substring-search

# up-down arrow search history using current prompt as prefix
########################################

# this is the only exception. substring search can be added after zsh-syntax-highlighting

zinit ice depth=1 wait lucid atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down;"
zinit load zsh-users/zsh-history-substring-search

########################################
# fig post block
########################################

. "$HOME/.fig/shell/zshrc.post.zsh"

########################################
# END - anything added below this line should be removed and placeed
# in scripts above
########################################