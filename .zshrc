export ZSH="$HOME/.oh-my-zsh"                                           # Path to your oh-my-zsh installation.

# theme                                                                 # See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"                                                   # spaceship config is in ~/.spaceshiprc.zsh
ZSH_DISABLE_COMPFIX=true

# zsh options
# zstyle ':omz:update' mode disabled                                    # disable automatic updates
zstyle ':omz:update' frequency 13

DISABLE_MAGIC_FUNCTIONS="true"                                          # Uncomment the following line if pasting URLs and other text is messed up.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c757d"
# DISABLE_LS_COLORS="true"                                              # Uncomment the following line to disable colors in ls.
# DISABLE_AUTO_TITLE="true"                                             # Uncomment the following line to disable auto-setting terminal title.
# ENABLE_CORRECTION="true"                                              # Uncomment the following line to enable command auto-correction.
# DISABLE_UNTRACKED_FILES_DIRTY="true"                                  # Uncomment the following line if you want to disable marking untracked files
                                                                        # under VCS as dirty. This makes repository status check for large repositories
                                                                        # much, much faster.
# HIST_STAMPS="mm/dd/yyyy"                                              # Uncomment the following line if you want to change the command execution time
                                                                        # stamp shown in the history command output.
                                                                        # You can set one of the optional three formats:
                                                                        # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
                                                                        # or set a custom format using the strftime function format specifications,
                                                                        # see 'man strftime' for details.

# plugins                                                               # Standard plugins can be found in $ZSH/plugins/
                                                                        # Custom plugins may be added to $ZSH_CUSTOM/plugins/
                                                                        # Add wisely, as too many plugins slow down shell startup.
plugins=(
	zsh-autosuggestions 
	history 
)

source $ZSH/oh-my-zsh.sh

if [ -f ~/.asdf/asdf.sh ]; then
    . $HOME/.asdf/asdf.sh
fi

# aliases                                                               # For a complete list, run `alias`
alias notes="nvim $NOTES"
alias g="git"                                                           # git aliases
alias stats="git status"
alias commit="git commit"
alias pull="git pull"
alias checkout="git checkout"
alias pull="git pull"
alias push="git push"
alias stash="git stash"
alias add="git add"
alias restore="git restore"
alias cherry-pick="git cherry-pick"
alias vdir="nvim ~/.config/nvim/"                                       # neovim config dir
alias config="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME" # dotfiles bare repo
alias sudoenv="sudo -E env 'PATH=$PATH'"                                # user envs as root
alias rip="rip --graveyard ~/.local/share/graveyard"                    # move to graveyard instead of just remove
alias fd="fdfind"
alias v=nvim
alias cls="clear"
alias games="ls /usr/games/"

# envs

export NOTES=$HOME/notes/
export NOTES_INBOX=$HOME/notes/00-inbox/
#export PATH=$HOME/jdtls/bin:$PATH
#export PATH=$PATH:$HOME/.asdf/installs/golang/1.20.3/packages/bin
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/bin/scripts:$PATH
export JAVA_HOME=$(asdf where java)
export BG_COLOR="#181818"

# scripts to run every new terminal

# colorscript random
# neofetch

if [[ -z $DISPLAY && $(tty) == /dev/tty2 ]]; then
  XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 exec startx
fi

if [ -d ~/.kube ]; then
  for file in $(find ~/.kube -type f -name "*.yaml" -o -name "*.yml"); do
      export KUBECONFIG=$KUBECONFIG:$file
  done
fi

if [ -f ~/.config/vpn/env.sh ]; then
    source ~/.config/vpn/env.sh
fi

eval "$(zoxide init zsh)"
