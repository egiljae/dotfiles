LN_FLAGS = -sf

symlinks = .bashrc .bash_aliases .bash_functions .tmux.conf .vimrc .zshrc \
		   .gitignore .gitconfig

symdirs = .ncmpcpp .vim .pulse
		   
.PHONY: $(symlinks) $(symdirs)

all: install

$(symlinks):
	test ! -f $(PWD)/dot$@ || ln $(LN_FLAGS) $(PWD)/dot$@ ~/$@

$(symdirs):
	rm -rf ~/$@
	test ! -d $(PWD)/dot$@ || ln $(LN_FLAGS) $(PWD)/dot$@/ ~/$@


zsh-syntax:
	test -d ~/.zsh/zsh-syntax-highlighting/ || \
	   	(git clone --quiet git://github.com/zsh-users/zsh-syntax-highlighting.git \
		~/.zsh/zsh-syntax-highlighting)

install: $(symlinks) $(symdirs) zsh-syntax
