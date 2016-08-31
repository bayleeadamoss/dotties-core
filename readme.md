## Dotties

This Mac tool allows you to have dotfiles synced on github and gives you the ability
to have shared behaviors and packages.

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

## Structure

Dotties allows packages to have their own dotfiles that are also on your
computer. So even if you have a `tmux.conf` in your dotties, a package can also
define their own and both will be included correctly.

This is achieved by putting a single `~/.tmux.conf` in your home directory that
sources both your file and your packages file.

Plugins are installed in `~/.dotties/packages/${USERNAME-REPO}` and are never
modified by dotties, so feel free to edit these files in place and commit them
back to GitHub.
