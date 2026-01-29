export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/Repositories/config/oh-my-zsh"
export ZSH_TMUX_AUTOSTART=true
export PERLBREW_ROOT="$HOME/.perl5"
export plugins=(
	"F-Sy-H"
	"alias-tips"
	"brew"
	"common-aliases"
	"fzf"
	"gh"
	"git"
	"history"
	"last-working-dir"
	"tmux"
	"zsh-autosuggestions"
	"zsh-completions"
	"zsh-vi-mode"
)
# https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands
zvm_after_init_commands+=('[ -f "$(command -v fzf)" ] && source <(fzf --zsh)')
# Direnv should take a snapshot _after_ all initialization is done to capture the full environment faithfully.
zvm_after_init_commands+=('[ -f "$(command -v direnv)" ] && source <(direnv hook zsh)')
# shellcheck disable=SC1091
[ -f "$ZSH/oh-my-zsh.sh" ] && source "$ZSH/oh-my-zsh.sh"
