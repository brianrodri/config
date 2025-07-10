export EDITOR=nvim
if [ -f "$(command -v brew)" ]; then
  export LDFLAGS="-L$(brew --prefix)/opt/llvm/lib"
  export CPPFLAGS="-I$(brew --prefix)/opt/llvm/include"
fi
