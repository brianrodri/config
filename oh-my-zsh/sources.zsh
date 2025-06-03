# https://ohmyposh.dev/docs/installation/prompt
[ -f "$(command -v oh-my-posh)" ] && eval "$(oh-my-posh init zsh --config "$HOME/.oh-my-posh.yaml")"

# https://metacpan.org/pod/local::lib#The-bootstrapping-technique
[ -f "$(command -v perl)" ] && eval "$(perl -I$HOME/.perl5/lib/perl5 -Mlocal::lib=$HOME/.perl5)"
