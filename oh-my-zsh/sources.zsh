if [ -f "$(command -v oh-my-posh)" ]; then
  # https://ohmyposh.dev/docs/installation/prompt
  eval "$(oh-my-posh init zsh --config "$HOME/.oh-my-posh.yaml")"
fi

if [ -f "$(command -v cargo)" ]; then
  source "$HOME/.cargo/env"
fi

if [ -d "$HOME/.perl5" ]; then
  # https://metacpan.org/pod/local::lib#The-bootstrapping-technique
  eval "$(perl -I$HOME/.perl5/lib/perl5 -Mlocal::lib=$HOME/.perl5)"
fi
