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
    zsh-syntax-highlighting
	history 
)

#bindkey '^I' autosuggest-accept                                         # Tab to accept autosuggestion

# colorscript random
# neofetch

source $ZSH/oh-my-zsh.sh
source ~/.local/bin/scripts/j

# if [ -f ~/.asdf/asdf.sh ]; then
#     . $HOME/.asdf/asdf.sh
# fi

# if [[ -z $DISPLAY && $(tty) == /dev/tty2 ]]; then
#   XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 exec startx
# fi

if [ -d ~/.kube ]; then
  for file in $(find ~/.kube -type f -name "*.yaml" -o -name "*.yml"); do
      export KUBECONFIG=$KUBECONFIG:$file
  done
fi

if [ -f ~/.config/vpn/env.sh ]; then
    source ~/.config/vpn/env.sh
fi

if [ -f ~/.ssh/agent.env ] ; then
    . ~/.ssh/agent.env > /dev/null
    if ! kill -0 $SSH_AGENT_PID > /dev/null 2>&1; then
        echo "Stale agent file found. Spawning a new agent. "
        eval `ssh-agent | tee ~/.ssh/agent.env`
        ssh-add
    fi
else
    echo "Starting ssh-agent"
    eval `ssh-agent | tee ~/.ssh/agent.env`
    ssh-add
fi

function gitstash() {
    local name="$1"
    if [ -z $name ]; then
        echo "Should provide a stash name or index"
        exit 1
    fi
    git stash apply $(git stash list --pretty='%gd %s'| grep "$1" |head -1| awk '{print $1}')
}

function gitpush() {
    git push -u origin $(git branch --show-current)
}

function jsondiff() {
    local fileA="$1"
    local fileB="$2"

    if [[ -z $fileA || -z $fileB ]]; then
        echo "ERROR: Should provide a two json files: jsondiff A.json B.json <diff args>"
        exit 1
    fi

    shift 2
    local args=("$@")

    diff "${args[@]}" <(jq --sort-keys . $fileA ) <(jq --sort-keys . $fileB )
}

# set JAVA_HOME on every change directory
# https://github.com/halcyon/asdf-java/issues/51#issuecomment-611049565
function asdf_update_java_home {
  asdf current java 2>&1 > /dev/null
  if [[ "$?" -eq 0 ]]
  then
      export JAVA_HOME=$(asdf where java)
  fi
}

precmd() { asdf_update_java_home; }
# end set JAVA_HOME

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
alias k="kubectl"
alias vdir="nvim ~/.config/nvim/"                                       # neovim config dir
alias config="/usr/bin/git -C $HOME/dot/"                               # dotfiles managed with stow
alias sudoenv="sudo -E env 'PATH=$PATH'"                                # user envs as root
alias rip="rip --graveyard ~/.local/share/graveyard"                    # move to graveyard instead of just remove
alias fd="fdfind"
alias v=nvim
alias cls="clear"
alias games="ls /usr/games/"

# envs

export ASDF_DATA_DIR=$HOME/.asdf
export NOTES=$HOME/notes/
export NOTES_INBOX=$HOME/notes/00-inbox/
export NOTES_PATH=$HOME/notes/01-Main\ Notes
export PATH=$HOME/.local/bin:$PATH
#export PATH=$HOME/jdtls/bin:$PATH
export PATH=$HOME/.local/bin/scripts:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=$ASDF_DATA_DIR/shims:$PATH
# export NODEJS_VERSION=$(asdf current --no-header nodejs | awk '{print $2}')
# export PATH=$ASDF_DATA_DIR/installs/nodejs/$NODEJS_VERSION/bin:$PATH
# export JAVA_HOME=$(asdf where java)
export BG_COLOR="#181818"

# TODO: export somente se existir asdf

eval "$(zoxide init zsh)"
