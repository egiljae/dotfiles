# Use modern completion system
autoload -Uz compinit
compinit

# Use emacs keybindings even if our EDITOR is set to vi
# bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Don't log my spaces!
setopt histignorespace

# Trying something simpler
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Adds slashes to dots! \o/
function rationalise-dot() {
    if [[ $LBUFFER = *.. ]]; then
        LBUFFER+=/../
    else
        LBUFFER+=.
    fi
}
zle -N rationalise-dot
bindkey . rationalise-dot

# Spelling correction
setopt correct

# Host completion
if [ -f $HOME/.hosts ]; then
    zstyle ':completion:*:(ssh|rsync|scp):*' hosts "${(f)$(awk '{print $2}' <$HOME/.hosts)}"
fi

# Enable cache for completions
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

setopt extended_glob

# Some enviromental/shell pref stuff
setopt EXTENDED_HISTORY # puts timestamps in the history
setopt ALL_EXPORT

# Colors
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
    (( count = $count + 1 ))
done

# Prompt
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="$PR_BLUE%n$PR_WHITE@$PR_GREEN%m%u$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR%(!.#.$) "

# For macbook
if which battery &> /dev/null; then
    RPROMPT="$PR_NO_COLOR%D{[%H:%M} -$(battery)$PR_NO_COLOR]$PR_NO_COLOR"
else
    RPROMPT="$PR_LIGHT_WHITE%D{[%H:%M]}$PR_NO_COLOR"
fi

# Fix home, end and delete
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[[3~' delete-char

# Allow comments interactive shell
setopt interactivecomments

# Set editor to vim
if [[ -x /usr/bin/vim ]]; then
    export EDITOR='vim'
fi

# Load aliases
if [[ -s ~/.bash_aliases ]]; then
    . ~/.bash_aliases
fi

# Suggest package for command not found
if [[ -s /etc/zsh_command_not_found ]]; then
    . /etc/zsh_command_not_found
fi

# Download zsh-syntax-highlighting
if [ ! -f ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    echo "Could not find zsh-syntax-highlighting, downloading.."
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh-syntax-highlighting
fi
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Link rest of dotfiles
if [ ! -L $HOME/.bash_aliases ]; then
    ln -s $HOME/dotfiles/dot.bash_aliases $HOME/.bash_aliases
fi
if [ ! -L $HOME/.vimrc ]; then
    ln -s $HOME/dotfiles/dot.vimrc $HOME/.vimrc
fi
if [ ! -L $HOME/.tmux.conf ]; then
    ln -s $HOME/dotfiles/dot.tmux.conf $HOME/.tmux.conf
fi
