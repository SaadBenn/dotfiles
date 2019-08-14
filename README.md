![dotfiles](https://dotfiles.github.io/images/dotfiles-logo.png)

These are the dotfiles I am using on Mac OS X. 

Running the setup of these dotfiles should install Homebrew (OS X only) and
Node.js for you.

## Using These
```
$ curl -L https://git.io/vb6Rp > setup.sh
$ bash setup.sh
```
This should do the trick.

## Utility Commands / Aliases

### `reload!`


### `dot`
Updates dotfiles from Github repo, also updates homebrew, homebrew packages and
global NPM packages.

## Notes
1. In order to remove the need to `sudo` every time I install global npm
packages, I repurposed `~/.npm` from npm cache into the install directory for
all global npm modules. So, the new npm cache will live in `~/.npm/cache`, while
npm prefix will be changed to `~/.npm`

## License

MIT

[Logo](http://github.com/jglovier/dotfiles-logo/) by [Joel Glovier](https://github.com/jglovier).
