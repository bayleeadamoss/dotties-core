## Dotties

Dotties is a Mac tool for managing your dotfiles via GitHub.

Dotties packages are extensions that can be shared. Your entire dotfiles repo
is a dotties package, so you can install it on multiple computers to keep your
dotfiles in sync. You can also install extensions from others to enhance your
own dotfiles. For example, the search behavior in `.vimrc` can be extracted as
an extension which can be added to your existing configuration through dotties
package management.

To get started check out [my core file](https://github.com/blainesch/dotties)

## How does it work?

Dotties package is just a collection of dotfiles such as `vimrc`, `tmux.conf`
etc. Dotties will make sure that your config file and the package's config file
are both included correctly.

In order to achieve this Dotties will create a single config file (say
`~/.tmux.conf`) that sources both your `tmux.conf` and your package's
`tmux.conf`.

Files from the packages are installed in `~/.dotties/packages/${USERNAME-REPO}`
and are never modified by dotties, so feel free to update these files in place
and commit them back to GitHub.

## Insalling on OS X

You can install dotties from [Homebrew](http://brew.sh/).

~~~
brew install bayleeadamoss/formulae/dotties
~~~

## Installing on Ubuntu

### Install rvm

~~~
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash
source /etc/profile.d/rvm.sh
rvm install ruby-2.2
~~~

### Install dotties

~~~
cd /tmp
git clone https://github.com/bayleeadamoss/dotties-core.git
cd dotties-core/bin
mv ../lib /usr/local/bin/.dotties-lib
cat dotties | sed -e 's|../lib|.dotties-lib|g' > /usr/local/bin/dotties
~~~

## Getting started

Create a repo on GitHub with your dotfiles inside of it.

Let's assume the directory structure looks like this:

~~~
dotfiles/
|-- vimrc
|-- tmux.conf
~~~

Dottie works with GitHub for package management, so any short GitHub url can be
a dotties package. For instance `https://github.com/blainesch/dotties` would be
installed as `blainesch/dotties`. So converting your current dotfiles into a
dotties repo is seamless.

To install a repo simply run:

~~~
dotties install bayleedev/dotties
~~~

## .dotties.yml

Optionally, you can have a `.dotties.yml` if you wish to include additional
packages or you want to ignore files such as a `readme` or pictures of your dog.

A simple `.dotties.yml` might look lke this:

~~~ yaml
packages:
  - bayleeadamoss/dotties-vim-movements
ignore:
  - readme.md
~~~

This says that next time you install or update your dotfiles to ignore the
`readme.md` file and to include the package
`bayleeadamoss/dotties-vim-movements`.
