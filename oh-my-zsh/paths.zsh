if [[ -f "$(command -v gem)" ]]; then; export PATH="$(gem env gemdir)/bin:$PATH"; fi
export MANPATH="$HOME/.cache/cppman:$MANPATH"
export PATH="$HOME/.local/bin:$PATH"
