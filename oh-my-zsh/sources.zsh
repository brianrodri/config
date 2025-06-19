if [ -f "$(command -v oh-my-posh)" ]; then
  # https://ohmyposh.dev/docs/installation/prompt
  eval "$(oh-my-posh init zsh --config "$HOME/.oh-my-posh.yaml")"
fi

if [ -d "$HOME/.perl5" ]; then
  # https://metacpan.org/pod/local::lib#The-bootstrapping-technique
  eval "$(perl -I$HOME/.perl5/lib/perl5 -Mlocal::lib=$HOME/.perl5)"
fi

if [ -f "$(command -v pyenv)" ]; then
  # https://github.com/pyenv/pyenv#b-set-up-your-shell-environment-for-pyenv
  eval "$(pyenv init --path)"
  # https://github.com/pyenv/pyenv-virtualenv#installing-with-homebrew-for-macos-users
  eval "$(pyenv virtualenv-init -)"
fi
