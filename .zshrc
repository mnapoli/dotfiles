# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
#ZSH_THEME="ys"
ZSH_THEME="" # theme disabled -> use pure

# Aliases
alias grep="grep --color"
alias git=hub
alias gitprune="git branch --merged | grep -v master | xargs git branch -d"
alias dc="docker-compose"
alias dce="docker-compose exec"
alias prettycitunnel="ssh -L 3309:ssh.prettyci.com:3306 forge@ssh.prettyci.com"

# Less syntax highlighting
# https://ole.michelsen.dk/blog/syntax-highlight-files-macos-terminal-less.html
LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to disable command auto-correction.
DISABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew git git-extras composer node npm symfony2 heroku docker-compose zsh-syntax-highlighting zsh-history-substring-search)

source $ZSH/oh-my-zsh.sh

# User configuration

export PATH=./vendor/bin:$HOME/.composer/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Preferred editor
export EDITOR='nano'

# Bind UP and DOWN arrow keys for zsh-history-substring-search
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# for Ubuntu
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Disable shared history between terminal windows
setopt APPEND_HISTORY

# Source local config
[ -f ~/.localrc ] && source ~/.localrc

# Pure prompt
# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure


# Automatically added by the Platform.sh CLI installer
export PATH="/Users/matthieu/.platformsh/bin:$PATH"
. '/Users/matthieu/.platformsh/shell-config.rc' 2>/dev/null || true

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export GOPATH=${HOME}/dev/go

# Docker Compose magic
docker_compose_start_if_stopped () {
    export DC_MAIN_SERVICE=`yq '.services|keys[0]' docker-compose.yaml --raw-output`
    STATE=`docker-compose ps $DC_MAIN_SERVICE | tail -n 1 | awk '{print $5}'`
    if [ "$STATE" != "Up" ]
    then
        docker-compose start $DC_MAIN_SERVICE
    fi
}
alias d="docker_compose_start_if_stopped && docker-compose exec $DC_MAIN_SERVICE"
