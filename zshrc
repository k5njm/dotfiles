# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Completions
autoload -U compinit && compinit
autoload -U +X bashcompinit && bashcompinit
if command -v terraform >/dev/null 2>&1; then
    complete -o nospace -C "$(command -v terraform)" terraform
fi

### Exports ###
export EDITOR=vim
export ZSH=$HOME/.oh-my-zsh

### ZSH Config ###
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions kubectl)
source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/homebrew/bin:/home/linuxbrew/.linuxbrew/bin:$PATH

### Aliases ###
alias k=kubectl
alias kg='kubectl get'
alias kd='kubectl describe'
alias "docker-compose"="docker compose"
alias vim=nvim # Here goes neovim!
alias e='tmux capture-pane -pS - | code - &'
alias pushup='git push -u origin HEAD'
alias ls='ls -lah'



# OS Specific
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Commands for macOS
    alias example1='command_for_mac'
    alias o="open $(pwd)"

else                  
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
  alias open=nautilus
  alias apt=dnf
  alias o="/usr/bin/nautilus $(pwd)"

fi

### Functions

# Update dotfiles
function dfu() {
    (
        cd ~/.dotfiles && git pullff && ./install -q
    )
}

# Base64 encode function
function b64enc() {
    echo -n ${1} | base64
}

# Base64 decode function
function b64dec() {
    echo -n ${1} | base64 -D
}