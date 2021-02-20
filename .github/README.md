# Bootstrap MacOS

These are my dotfiles for bootstrapping my Mac.
It's not actually empty.
I use [yadm](https://github.com/TheLocehiliosan/yadm) to manage my dotfiles and store everything in [`.config/yadm/alt`](../.config/yadm/alt).

## Features

- shell
  - zsh with zinit as a package manager for fast startups!
  - powerlevel10k for a pretty prompt
  - tmux for split panes goodies
- packages
  - brew bundle to manage brew packages and casks
- terminal
  - kitty terminal (for speed and battery life)
- guake style applications
  - like iterm but for everything 🦄
- gpg and ssh key generation
  - no more fiddling around, just hit yes and upload to github 🚀

## Common Tasks

Install your dotfiles (first time)

```sh
# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# install yadm
brew install yadm
# clone this repo and run the bootstrap script
yadm clone --bootstrap -f https://github.com/lukesmurray/bootstrap.git ;
```

Update dotfiles

```sh
cd ; yadm pull && yadm alt && yadm bootstrap ;
```

Edit your dotfiles in an editor.

```sh
cd; yadm list -a | xargs ${EDITOR}
```

## Todo

- Alfred - store key somewhere
- Vscode settings - instructions for syncing
- duti - default apps
- mackup - instructions for backing up and restoring files

## Testing

[Install macOS on a separate volume](https://support.apple.com/en-us/HT208891) and test the bootstrap on that volume.

## Troubleshooting

if you're getting messages about insecure directories run from [stack overflow](https://stackoverflow.com/questions/13762280/zsh-compinit-insecure-directories)

```
compaudit | xargs chmod g-w
```

if you want to clean up zinit plugins

```
zinit delete --clean
```
