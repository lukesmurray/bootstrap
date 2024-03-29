# All Files

## .Brewfile

`.Brewfile` provides a single file to manage all of the dependencies installed by homebrew.
The `.Brewfile` is used by [homebrew-bundle](https://github.com/Homebrew/homebrew-bundle) and defines what is installed when you run `brew bundle install`.

Homebrew is just a github repo of ruby files (called formula) that are used to install programs.

Once homebrew is installed on your computer you can view all of the formula in `$(brew --repository)/Library/Taps/homebrew/homebrew-core/Formula`.

By default homebrew can only install programs from [homebrew-core](https://github.com/Homebrew/homebrew-core).

Third parties can define their own repositories of formulae that you can install.
These repositories are called Taps.
Taps are named with the pattern `<user/repo>` and installed with `brew tap <user/repo>`.
You can view the github repo for a tap `<user/repo>` at `https://github.com/<user>/homebrew-<repo>`.
You can view the the taps on your computer at `$(brew --repository)/Library/Taps/<user>/homebrew-<repo>`.

Once you have the tap installed you can install formula and casks from the tap.

Homebrew casks are an extension of homebrew used to install macOS native apps.
Casks are used to install closed source or GUI-only programs.

| Action                                               | Command                                    |
| :--------------------------------------------------- | :----------------------------------------- |
| install everything in brewfile                       | ACCEPT_EULA=y brew bundle install          |
| install everything in global brewfile `~/.Brewfile`  | ACCEPT_EULA=y brew bundle install --global |
| list installed casks not listed in brewfile          | brew bundle cleanup                        |
| list installed casks not listed in global brewfile   | brew bundle cleanup --cleanup              |
| remove installed casks not listed in brewfile        | brew bundle cleanup --force                |
| remove installed casks not listed in global brewfile | brew bundle cleanup --global --force       |

## .config/direnv/direnvrc

Config file for direnv.
See notes below for how direnv works.

## .config/kitty/kitty.conf

Configuration for kitty.
Contains comments describing all the basic options.
Also provides keybinding replication for most of the features I used in tmux.

## .config/kitty/theme.conf

Visual Studio Dark theme for kitty.

## .config/kitty/zoom_toggle.py

Implements a toggle for making a pane in Kitty take up an entire tab.

## .config/spotify-tui/config.yml

<!-- TODO(lukemurray): document -->

## .config/spotifyd/spotifyd.conf

<!-- TODO(lukemurray): document -->

## .config/yadm/bootstrap

Bootstrap script for yadm.
Can be executed using `yadm bootstrap`.

<!-- TODO(lukemurray): fix the decryption step and make self contained -->

## .config/yadm/encrypt

<!-- TODO(lukemurray): document -->

## .default-python-packages

<!-- TODO(lukemurray): document -->

## .duti

From the duti man page.
Read the comments in the file to see how it works.

## .envrc

Defines variables used to configure programs using

```
export VARNAME='value'
```

Also defines environment variables such as `path` and `fpath`.

## .gitconfig

<!-- TODO(lukemurray): document -->

## .github/README.md

Readme for this repository

## .github/toc.md

The file you are reading

## .gitignore

Git ignore for this directory.
Very strict, otherwise editing dotfiles in the home directory will freeze vscode.

## .gitignore_global

Global git ignore.
Set as `git config --global core.excludesfile`.

## .gnupg/gpg-agent.conf

<!-- TODO(lukemurray): document -->

## .hushlogin

<!-- TODO(lukemurray): document -->

## .inputrc

<!-- TODO(lukemurray): document -->

## .local/share/yadm/archive

<!-- TODO(lukemurray): document -->

## .mackup.cfg

<!-- TODO(lukemurray): document -->

## .macos

<!-- TODO(lukemurray): document -->

## .p10k.zsh

Configuration file for [powerlevel10k](https://github.com/romkatv/powerlevel10k).
Use this file to control the zsh prompt.

## .phoenix.js

<!-- TODO(lukemurray): document -->

## .ssh/config

<!-- TODO(lukemurray): document -->

## .tool-versions

asdf uses `.tool-versions` to determine the version of software to use.
The root `.tool-versions` sets the version of software used across the system by asdf unless it is overridden by a `.tool-versions` in a sub-directory.

## .zshrc

We use [zinit](https://github.com/zdharma-continuum/zinit) as a plugin manager for zsh.

Zinit lets you load zsh plugins ([see zsh plugin standard](https://zdharma-continuum.github.io/zinit/wiki/zsh-plugin-standard/)) using the command `zinit load <user/repo>` or `zinit light <user/repo>`.
`load` uses reporting so that you can track what the plugin does using `zinit report {plugin}`.

Zinit lets you download single files using `zinit snippet <file-url>`.
You can use `zinit ice` before a zinit command to control what happens once the file is loaded.
Zinit maintains a list of [ice modifiers](https://github.com/zdharma-continuum/zinit#ice-modifiers) in the readme.

| Action                                      | Command                     |
| :------------------------------------------ | :-------------------------- |
| update zinit                                | `zinit self-update`         |
| update zinit plugins                        | `zinit update`              |
| unload a plugin                             | `zinit unload <pluginname>` |
| remove unused plugins or snippets from disk | `zinit delete --clean`      |
| list completions                            | `zinit clist`               |

## Brewfile.lock.json

Lockfile produced by `brew bundle install` which makes `brew bundle install` reproducible.

# Tools

## asdf

asdf is a single command line tool for managing versions of multiple pieces of software.

| Action                                | Command                                                                |
| :------------------------------------ | :--------------------------------------------------------------------- |
| add a plugin for a tool               | `asdf plugin add <plugin-name>`                                        |
| install a version for a tool          | `asdf install <plugin-name> <version>`                                 |
| the latest version                    | `latest` can be used as a synonym for latest version across asdf.      |
| set a global version of a tool        | `asdf global <plugin-name> <version>`. Modifies `~/.tool-versions`.    |
| set a local version of a tool         | `asdf local <plugin-name> <version>`. Modifies `${PWD}/.tool-versions` |
| install all tools in `.tool-versions` | `asdf install` in directory containing `.tool-versions` file           |
| update all plugins                    | `asdf plugin update --all`                                             |
| list currently installed plugins      | `asdf plugin-list`                                                     |
| use direnv version of tool            | `asdf direnv local <plugin-name> <version>`                            |

## direnv

Helps you configure per directory environments.
Before each prompt direnv checks for a `.envrc` file in the current and parent directories.
If the file exists it is loaded into a **bash** sub-shell and all exported variables are made available to the current shell.
Direnv provides a stdlib of functions available to use in `.envrc` documented in [direnv-stdlib](https://github.com/direnv/direnv/blob/master/man/direnv-stdlib.1.md).
The most useful function is `layout <type>` which can be used to set up a common project layout.

_Example Python Project Setup_

```zsh
# set up the version of python for the project
asdf direnv local python <version>
# open .envrc in $EDITOR
direnv edit
# edit the .envrc to add `layout python` below `use asdf`

# final envrc
# use asdf
# layout python
```

| Action                                                         | Command          |
| :------------------------------------------------------------- | :--------------- |
| allow the envrc in the current directory                       | `direnv allow .` |
| edit the .envrc file in a directory and automatically allow it | `direnv edit`    |

## lsd

Drop in replacement to `ls` that shows more information about files.

## hub

<!-- TODO(lukemurray): document -->

## mas

<!-- TODO(lukemurray): document -->

## git-delta

<!-- TODO(lukemurray): document -->

## gpg

<!-- TODO(lukemurray): document -->

## yadm

<!-- TODO(lukemurray): document -->

## git

<!-- TODO(lukemurray): document -->

## mackup

<!-- TODO(lukemurray): document -->

# Important paths

We follow the pattern implemented by Gnome and Ubuntu.

$XDG_DATA_HOME defines the base directory relative to which user-specific data files should be stored. If $XDG_DATA_HOME is either not set or empty, a default equal to $HOME/.local/share should be used.

$XDG_CONFIG_HOME defines the base directory relative to which user-specific configuration files should be stored. If $XDG_CONFIG_HOME is either not set or empty, a default equal to $HOME/.config should be used.

$XDG_STATE_HOME defines the base directory relative to which user-specific state files should be stored. If $XDG_STATE_HOME is either not set or empty, a default equal to $HOME/.local/state should be used.

User-specific executable files may be stored in $HOME/.local/bin.

$XDG_CACHE_HOME defines the base directory relative to which user-specific non-essential data files should be stored. If $XDG_CACHE_HOME is either not set or empty, a default equal to $HOME/.cache should be used.

# TODOs

- add setting for .gitkeep in global
- understand https://zsh.sourceforge.io/Doc/Release/Expansion.html#Process-Substitution
- read the git book
