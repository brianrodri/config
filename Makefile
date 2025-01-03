DOT_FILES = tmux.conf zshrc p10k.zsh

install: $(DOT_FILES)
	git submodule init
	git submodule update
	for dot_file in $(DOT_FILES); do ln -f $${dot_file} $$HOME/.$${dot_file}; done

install-ghostty:
	mkdir -p "${HOME}/.config"
	ln -s "${PWD}/ghostty" "${HOME}/.config/ghostty"

install-nvim:
	mkdir -p "${HOME}/.config"
	ln -s "${PWD}/nvim" "${HOME}/.config/nvim"

clean:
	for dot_file in $(DOT_FILES); do rm -f $$HOME/.$${dot_file}; done
	rm -rf ${HOME}/.config/ghostty
	git submodule deinit --all
