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

## .config/yadm/encrypt

## .default-python-packages

## .duti

## .exports

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

## .phoenix.js

## .ssh/config

## .tmux.conf

## .tmux.conf.local

## .tool-versions

## .zshrc

## Brewfile.lock.json

Lockfile produced by `brew bundle install` which makes `brew bundle install` reproducible.
