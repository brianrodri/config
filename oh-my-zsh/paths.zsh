if [ -f "$(command -v cppman)" ]; then
  export MANPATH="$HOME/.cache/cppman:$MANPATH"
fi

if [ -f "$(command -v brew)" ]; then
  export PATH="$(brew --prefix)/bin:$PATH"
  export PATH="$(brew --prefix)/sbin:$PATH"
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

if [ -f "$(command -v rustup)" ]; then
  export PATH="$(brew --prefix rustup)/bin:$PATH"
fi

if [ -f "$(command -v cargo)" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH="$HOME/.local/bin:$PATH"
