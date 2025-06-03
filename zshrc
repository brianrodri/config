export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/Repositories/config/oh-my-zsh"
export ZSH_TMUX_AUTOSTART=true
export plugins=(
	"F-Sy-H"
	"alias-tips"
	"brew"
	"common-aliases"
	"direnv"
	"fzf"
	"gem"
	"gh"
	"git"
	"git-commit"
	"history"
	"last-working-dir"
	"macos"
	"npm"
	"sublime"
	"sublime-merge"
	"tmux"
	"zsh-autosuggestions"
	"zsh-completions"
	"zsh-vi-mode"
)
# https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands
zvm_after_init_commands+=('[ -f "$(command -v fzf)" ] && source <(fzf --zsh)')
# shellcheck disable=SC1091
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
# https://ohmyposh.dev/docs/installation/prompt
type "oh-my-posh" &>/dev/null && eval "$(oh-my-posh init zsh --config "$HOME/.oh-my-posh.yaml")"
# https://metacpan.org/pod/local::lib#The-bootstrapping-technique
type "perl" &>/dev/null && eval "$(perl -I$HOME/.perl5/lib/perl5 -Mlocal::lib=$HOME/.perl5)"
# https://docs.brew.sh/Installation#post-installation-steps
type "brew" &>/dev/null && eval "$($(brew --prefix)/bin/brew shellenv)"
