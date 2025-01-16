export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/Repositories/config/oh-my-zsh"
export plugins=(
	"F-Sy-H"
	"alias-tips"
	"common-aliases"
	"direnv"
	"fzf"
	"gh"
	"git"
	"history"
	"starship"
	"tmux"
	"vi-mode"
	"zsh-autosuggestions"
	"zsh-completions"
)
# shellcheck disable=SC1091
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
