export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${HOME}/Repositories/config/oh-my-zsh"
export ZSH_THEME="agnoster"
export plugins=(
	"F-Sy-H"
	"alias-tips"
	"common-aliases"
	"direnv"
	"fzf"
	"gh"
	"git"
	"history"
	"tmux"
	"vi-mode"
	"zsh-autosuggestions"
	"zsh-completions"
)

# shellcheck disable=SC1091
source "${ZSH}/oh-my-zsh.sh"
