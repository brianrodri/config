export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/Repositories/config/oh-my-zsh"
export ZSH_TMUX_AUTOSTART=true
export PERLBREW_ROOT="$HOME/.perl5"
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
