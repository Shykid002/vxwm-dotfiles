#
# ~/.bashrc
#

export QT_QPA_PLATFORMTHEME=qt5ct
#export QT_STYLE_OVERRIDE=kvantum

# 1. Add your local bin directory to your system PATH
export PATH="$PATH:$HOME/.local/bin"

# 2. Set your favorite text editor
export EDITOR=nvim

# 3. If not running interactively, don't do anything
[[ $- != *i* ]] && return

# 4. Set system terminal aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias install='paru -S'
alias search='paru'
alias remove='paru -Rns'
alias doas='sudo'

# 5. Initialize Oh My Posh with your chosen theme
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/sim-web.omp.json)"

