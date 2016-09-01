## Dotties

Dotties is a Mac tool for managing your dotfiles via Github. 

Dotties packages are extensions that can be shared. Your entire dotfiles repo
is a dotties package, so you can install it on multiple computers to keep your
dotfiles in sync. You can also install extensions from others to enhance your
own dotfiles. For example, the search behavior in .vimrc can be extracted as an
extension which can be added to your existing configuration through dotties
package management.

Dottie works with Github for package management, so any short GitHub url can be
a dotties package. For instance `https://github.com/blainesch/dotties` would be
installed as `blainesch/dotties`. So converting your current dotfiles into a
dotties repo is seamless.

~~~
brew tap tinytacoteam/formulae
brew install dotties
~~~

To get started check out [my core file](https://github.com/blainesch/dotties)

~~~
dotties --version
dotties install blainesch/dotties
~~~

## Managing Packages

TO BE FILLED OUT. Include details such as dotties.yml, commands to install and update packages etc.

## How does it work?

Dotties package is just a collection of dotfiles such as vimrc, tmux.conf etc.
These files might already exist in your computer but dotties will make sure
that your config file and the package's config file are both included
correctly. 

In order to achieve this Dotteis will create a single config file (say
`~/.tmux.conf`) in your home directory that sources both your `tmux.conf` and
your package's `tmux.conf`.

Files from the packages are installed in `~/.dotties/packages/${USERNAME-REPO}`
and are never modified by dotties, so feel free to update these files in place
and commit them back to GitHub.
