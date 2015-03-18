## Usage

Installation:

```sh
$ # install ZSH
$ chsh -s `which zsh`
$ git clone https://github.com/mnapoli/dotfiles.git
$ cd dotfiles
$ ./install.sh
```

After installation, update composer dependencies:

```sh
$ composer global update
```

Update:

```sh
$ cd dotfiles
$ git pull
$ ./install.sh
```

## localrc

A `.localrc` file can contain local configurations:

```
# Z
. `brew --prefix`/etc/profile.d/z.sh

$(boot2docker shellinit 2>/dev/null)

# added by travis gem
source /Users/matthieu/.travis/travis.sh
```
