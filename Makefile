DOT_FILES = zshrc oh-my-posh.yaml
CONFIG_DIRS = ghostty tmux yamlfmt yamllint

install: $(DOT_FILES)
	git submodule init && git submodule update
	for dot_file in $(DOT_FILES); do ln -f "$${dot_file}" "$${HOME}/.$${dot_file}"; done
	for config_dir in $(CONFIG_DIRS); do ln -s "$${PWD}/$${config_dir}" "$${HOME}/.config/$${config_dir}"; done

clean:
	for config_dir in $(CONFIG_DIRS); do rm -rf "$${HOME}/.config/$${config_dir}"; done
	for dot_file in $(DOT_FILES); do rm -f "$${HOME}/.$${dot_file}"; done
	git submodule deinit --all
