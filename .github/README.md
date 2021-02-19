# Bootstrap MacOS

Bootstrap and dotfiles for macos, managed with [yadm](https://github.com/TheLocehiliosan/yadm).
Dotfiles are stored in `~/.config/yadm/alt` and sym linked into the home directory.
The bootstrap script is `~/.config/yadm/bootstrap`.

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
yadm pull && yadm alt && yadm bootstrap ;
```

Edit your dotfiles in an editor.

```sh
cd; yadm list -a | xargs code
```

## Architecture

Brew is used to manage installed programs. zinit is used to manage zsh. moderate amount of effort into setting up gpg and ssh automatically.

## TODO

- Alfred
- Vscode settings
- duti
- create separate system for mackup settings they are too private

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
