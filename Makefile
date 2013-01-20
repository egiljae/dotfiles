LN_FLAGS = -sf

symlinks = .bash_aliases .bash_functions .tmux.conf .vimrc .zshrc

symdirs = .ncmpcpp .vim
		   
.PHONY: $(symlinks) $(symdirs)

all: install

$(symlinks):
	test ! -f $(PWD)/dot$@ || ln $(LN_FLAGS) $(PWD)/dot$@ ~/$@

$(symdirs):
	rm -rf ~/$@
	test ! -d $(PWD)/dot$@ || ln $(LN_FLAGS) $(PWD)/dot$@/ ~/$@

install: $(symlinks) $(symdirs)
