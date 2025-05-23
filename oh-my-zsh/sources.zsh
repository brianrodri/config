function source_if_exists() { test -e "${1}" && source "${1}" }

# iTerm2 shell integration
source_if_exists "${HOME}/.iterm2_shell_integration.zsh"

# fzf shell integration
if [[ -f "$(command -v fzf)" ]]; then; source <(fzf --zsh); fi
