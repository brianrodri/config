export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/Repositories/config/oh-my-zsh"
export plugins=(
	"F-Sy-H"
	"alias-tips"
	"brew"
	"common-aliases"
	"direnv"
	"fzf"
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
	"vi-mode"
	"zsh-autosuggestions"
	"zsh-completions"
)
# shellcheck disable=SC1091
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"

# https://ohmyposh.dev/docs/installation/prompt
if type "oh-my-posh" &>/dev/null; then
	eval "$(oh-my-posh init zsh --config "$HOME/.oh-my-posh.toml")"
fi
