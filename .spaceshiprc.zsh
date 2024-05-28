# colors 
# https://wiki.archlinux.org/title/zsh#Colors
# https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg

SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=true
SPACESHIP_PROMPT_COLORFUL_PREFIXES=true 
SPACESHIP_PROMPT_COLORFUL_SUFFIXES=true 

SPACESHIP_USER_SHOW='always'
SPACESHIP_USER_COLOR='magenta'
SPACESHIP_USER_PREFIX=''

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX='['
SPACESHIP_TIME_SUFFIX='] ' 
SPACESHIP_TIME_COLOR='#585858'

SPACESHIP_DIR_PREFIX=''
SPACESHIP_DIR_COLOR='#ffaf5f'
#SPACESHIP_DIR_TRUNC_REPO=false

SPACESHIP_GIT_SYMBOL='~ '
SPACESHIP_GIT_BRANCH_COLOR='cyan'

SPACESHIP_CHAR_SYMBOL='| '

SPACESHIP_PROMPT_ORDER=(
  time          # Current time
  host          # Hostname section
  user          # Username section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
  #git_status
  #git_branch
  exec_time     # Execution time
  async         # Async jobs indicator
  #line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  sudo          # Sudo indicator
  char          # Prompt character
)
