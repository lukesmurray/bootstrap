#!/usr/bin/env zsh

# inspired by https://github.com/crivotz/dot_files/blob/master/linux/zplugin/zshrc

# PROFILE=1
if [[ $PROFILE == 1 ]]; then
  zmodload zsh/zprof
fi



########################################
# Instant Prompt
########################################

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

########################################
# Config Files
########################################

for file in ~/.{aliases,color_aliases,exports,functions}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

########################################
# Zinit Initialization
########################################

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

########################################
# Theme
########################################
zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

########################################
# Colors
########################################
zinit ice atclone"gdircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zinit light trapd00r/LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

########################################
# Zoxide for Autojump
########################################

# setup zoxide for jumping around
zinit wait lucid atinit'eval "$(zoxide init zsh)"' nocd for zdharma/null

########################################
# ASDF for language version management
########################################

# load asdf
zinit wait"0a" lucid atinit'source "$(brew --prefix asdf)/asdf.sh"' nocd for zdharma/null
# load asdf direnv plugin
zinit wait"0b" lucid atinit'eval "$(asdf exec direnv hook zsh)"' nocd for zdharma/null
direnv() { asdf exec direnv "$@"; }

########################################
# Plugins
########################################

# add some oh my zsh plugins
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
# git for aliases
# ssh-agent to setup and load ssh credentials
# tmux to start tmux
zinit wait lucid for \
        OMZP::git \
        OMZP::ssh-agent \
        OMZP::tmux

zinit wait lucid for \
  "MichaelAquilina/zsh-you-should-use"

# AUTOSUGGESTIONS
# max buffer to complete (avoid completing large pasted text)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
# trigger precmd hook at load and use ctrl+space to accept suggestions
zinit ice wait"0a" lucid atload'_zsh_autosuggest_start; bindkey "^ " autosuggest-accept;'
zinit light zsh-users/zsh-autosuggestions

# HISTORY SUBSTRING SEARCHING
# on up and down arrow search history
zinit ice wait"0b" lucid atload'bindkey "$terminfo[kcuu1]" history-substring-search-up; bindkey "$terminfo[kcud1]" history-substring-search-down'
zinit light zsh-users/zsh-history-substring-search

# TAB COMPLETIONS
zinit ice wait"0b" lucid blockf
zinit light zsh-users/zsh-completions

# preferred comletion order
zstyle ':completion:*' completer _expand _complete _ignored _approximate
# case insensitive
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# don't require dot prefix for files
setopt glob_dots

# don't sort ssh completion
zstyle ':completion:*:ssh:*' sort false
# don't sort git checkout completion
zstyle ':completion:*:git-checkout:*' sort false

# FZF
zinit ice lucid wait'0b' from"gh-r" as"program"
zinit light junegunn/fzf
# FZF BYNARY AND TMUX HELPER SCRIPT
zinit ice lucid wait'0c' as"command" pick"bin/fzf-tmux"
zinit light junegunn/fzf
# BIND MULTIPLE WIDGETS USING FZF
zinit ice lucid wait'0c' multisrc"shell/{completion,key-bindings}.zsh" id-as"junegunn/fzf_completions" pick"/dev/null"
zinit light junegunn/fzf


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

# Setting fd as the default source for fzf
# follow symlinks, exclude git, show hidden files and directories
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# FZF-TAB
zinit ice wait"1" lucid
zinit light Aloxaf/fzf-tab

# # preview directories with exa and files with bat
zstyle ':fzf-tab:complete:*' fzf-preview '[[ -f $realpath ]]  && bat --style=numbers --color=always --line-range :500 $realpath || [[ -d $realpath ]] && exa -1 --color=always $realpath'

# SPT Completions (completions for spotify tui)
zinit light-mode lucid wait has"spt" for \
  id-as"spt_completion" \
  as"completion" \
  atclone"spt --completions zsh > _spt" \
  atpull"%atclone" \
  run-atpull \
    zdharma/null


# SYNTAX HIGHLIGHTING
zinit ice wait"0c" lucid atinit"zpcompinit;zpcdreplay"
zinit light zdharma/fast-syntax-highlighting


########################################
# Vi Bindings
########################################

# vi mode
bindkey -v


# create a zli widget to yank to system clipboard in zsh vim
function vi-yank-xclip {
    zle vi-yank
    # echo the cut value to pbcopy
    echo "$CUTBUFFER" | pbcopy -i
}

# create the new widget
zle -N vi-yank-xclip
# bind the y key in vi to the new widget
bindkey -M vicmd 'y' vi-yank-xclip


########################################
# History
########################################

# increase histsize
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
# set history file
HISTFILE=~/.zsh_history
# write to history immediately not on shell exit
setopt INC_APPEND_HISTORY
# share history between shells
setopt SHARE_HISTORY
# add timestamp to hist and executation time
setopt EXTENDED_HISTORY
# removes blank lines from history
setopt HIST_REDUCE_BLANKS
# ignore duplicates when searching history
setopt HIST_FIND_NO_DUPS

########################################
# Bell Settings
########################################

# turn off bell
unsetopt BEEP

if [[ $PROFILE == 1 ]]; then
  zprof
  unset $PROFILE
fi

