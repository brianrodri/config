DOT_FILES = tmux.conf zshrc

install: $(DOT_FILES)
	git submodule init
	git submodule update
	for dot_file in $(DOT_FILES); do ln -f $${dot_file} $$HOME/.$${dot_file}; done

clean:
	for dot_file in $(DOT_FILES); do rm -f $$HOME/.$${dot_file}; done
	git submodule deinit --all
