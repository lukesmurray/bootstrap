# Bootstrap MacOS

These are my dotfiles for bootstrapping my Mac.
I use [yadm](https://github.com/TheLocehiliosan/yadm) to manage my dotfiles.

## Features

- shell
  - zsh with zinit as a package manager for fast startups and nice fzf integration
  - powerlevel10k for a pretty prompt
- packages
  - brew bundle to manage brew packages and casks
- terminal
  - kitty terminal (for speed and battery life)
  - replication of a bunch of tmux features with `ctrl+a` as a prefix
- quake style drop down applications
  - like iterm but for everything
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
# on the first run you may want to say yes to things
yadm clone --bootstrap -f https://github.com/lukesmurray/bootstrap.git ;
```

Update dotfiles

```sh
# on any follow up runs feel free to accept the defaults
cd ; yadm pull && yadm alt && yadm bootstrap ;
```

Edit your dotfiles in an editor.

```sh
cd; yadm list -a | xargs ${EDITOR}
```

Creating a python virtual environment.

```sh
# set local python version (sets .tool-versions)
asdf local python <PYTHON_VERSION>
# add the following to .envrc. use asdf caches the plugin environment.  layout python creates a virtual environment.
# use asdf
# layout python
```

Duti file

Get the bundle id for an app using `mdls -name kMDItemCFBundleIdentifier -r SomeApp.app`
Get the UTI for a file using `mdls -name kMDItemContentType -name kMDItemContentTypeTree -name kMDItemKind FILE`

Duti files consist of

```
app_id    UTI    role
```

Roles are `all`, `viewer`, `editor`, `shell`, and `none`.
See more info on the [man page](http://duti.sourceforge.net/duti.1.php).

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
