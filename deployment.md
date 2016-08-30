## Deployment to GitHub

1. Update `.version` file with `VERSION`
1. `git tag VERSION`
1. `git push --tags`

## Deployment to Homebrew

1. After pushing tag download `.tar.gz` file.
1. Obtain sha256 using: `shasum -a 256 file.tar.gz`
1. Update [formula](https://github.com/tinytacoteam/homebrew-formulae/blob/master/Formula/dotties.rb)
