# Direnv needs to be loaded after p10k's instant prompt
# See: https://github.com/romkatv/powerlevel10k?tab=readme-ov-file#how-do-i-initialize-direnv-when-using-instant-prompt
(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv export zsh)"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

(( ${+commands[direnv]} )) && emulate zsh -c "$(direnv hook zsh)"

export ZSH="${HOME}/.oh-my-zsh"
export ZSH_CUSTOM="${HOME}/Repositories/config/oh-my-zsh"
export ZSH_THEME="powerlevel10k"
export plugins=(
	"F-Sy-H"
	"alias-tips"
	"common-aliases"
	"gh"
	"git"
	"history"
	"tmux"
	"vi-mode"
	"zsh-autosuggestions"
	"zsh-completions"
)

# Set up fzf key bindings and fuzzy completion
# shellcheck source=/dev/null
source <(fzf --zsh)

# shellcheck disable=SC1091
source "${ZSH}/oh-my-zsh.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
