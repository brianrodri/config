if [[ -f "$(command -v gem)" ]]; then; export PATH="$(gem env gemdir)/bin:$PATH"; fi
export PATH="$HOME/.local/bin:$PATH"
