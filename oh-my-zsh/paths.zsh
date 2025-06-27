if [ -f "$(command -v cppman)" ]; then
  export MANPATH="$HOME/.cache/cppman:$MANPATH"
fi

if [ -f "$(command -v brew)" ]; then
  export PATH="$(brew --prefix)/bin:$PATH"
  export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
fi

if [ -f "$(command -v mise)" ]; then
  export PATH="$HOME/.local/share/mise/installs/lua/5.1/bin:$PATH"
fi

if [ -f "$(command -v gem)" ]; then
  # Ruby is not linked by default to avoid conflicts with macOS's builtins.
  export PATH="$(brew --prefix)/opt/ruby/bin:$PATH"
  # Link to `gem` binaries
  export PATH="$(gem environment gemdir)/bin:$PATH"
fi

if [ -f "$(command -v pyenv)" ]; then
  # https://github.com/pyenv/pyenv#b-set-up-your-shell-environment-for-pyenv
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"
