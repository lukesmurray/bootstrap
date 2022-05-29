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

| Action                                               | Command                              |
| :--------------------------------------------------- | :----------------------------------- |
| install everything in brewfile                       | brew bundle install                  |
| install everything in global brewfile `~/.Brewfile`  | brew bundle install --global         |
| list installed casks not listed in brewfile          | brew bundle cleanup                  |
| list installed casks not listed in global brewfile   | brew bundle cleanup --cleanup        |
| remove installed casks not listed in brewfile        | brew bundle cleanup --force          |
| remove installed casks not listed in global brewfile | brew bundle cleanup --global --force |

## .aliases

## .asdfrc

## .bin/.gitkeep

## .color_aliases

## .config/direnv/direnvrc

## .config/kitty/kitty.conf

## .config/kitty/theme.conf

## .config/kitty/zoom_toggle.py

## .config/spotify-tui/config.yml

## .config/spotifyd/spotifyd.conf

## .config/yadm/bootstrap

Bootstrap script for yadm.
Can be executed using `yadm bootstrap`.

<!-- TODO(lukemurray): fix the decryption step -->

## .config/yadm/encrypt

## .default-python-packages

## .duti

## .envrc

Defines variables used to configure programs using

```
export VARNAME='value'
```

Also defines environment variables such as `path` and `fpath`.

## .functions

## .gitconfig

## .github/README.md

## .gitignore

## .gitignore_global

## .gnupg/gpg-agent.conf

## .hushlogin

## .inputrc

## .local/share/yadm/archive

## .mackup.cfg

## .macos

## .p10k.zsh

Configuration file for [powerlevel10k](https://github.com/romkatv/powerlevel10k).
Use this file to control the zsh prompt.

## .phoenix.js

## .ssh/config

## .tmux.conf

## .tmux.conf.local

## .tool-versions

## .zshrc

We use [zinit](https://github.com/zdharma-continuum/zinit) as a plugin manager for zsh.

Zinit lets you load zsh plugins ([see zsh plugin standard](https://zdharma-continuum.github.io/zinit/wiki/zsh-plugin-standard/)) using the command `zinit load <user/repo>` or `zinit light <user/repo>`.
`load` uses reporting so that you can track what the plugin does using `zinit report {plugin}`.

Zinit lets you download single files using `zinit snippet <file-url>`.
You can use `zinit ice` before a zinit command to control what happens once the file is loaded.
Zinit maintains a list of [ice modifiers](https://github.com/zdharma-continuum/zinit#ice-modifiers) in the readme.

| Action               | Command           |
| :------------------- | :---------------- |
| update zinit         | zinit self-update |
| update zinit plugins | zinit update      |

## Brewfile.lock.json

Lockfile produced by `brew bundle install` which makes `brew bundle install` reproducible.
