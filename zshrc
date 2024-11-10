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

# TODO: Find a plugin that does this for me.
export FZF_BASE;
FZF_BASE=$(dirname "$(which fzf)")
# This is a command's output, not a file.
# shellcheck source=/dev/null
source <(fzf --zsh)

# shellcheck disable=SC1091
source "${ZSH}/oh-my-zsh.sh"
