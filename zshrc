# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${HOME}/Repositories/config/oh-my-zsh"
export ZSH_THEME="powerlevel10k"
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
