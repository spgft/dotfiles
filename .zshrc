# Path to your Oh My Zsh installation
# alias ls='ls --color=auto'
alias cd='z'
alias ci='zi'
alias l='ls -la'
# ---------- Environment Variables ----------
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# ---------- Pyenv ----------
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# ---------- zoxide ----------
eval "$(zoxide init zsh)"

# ---------- History ----------
# ---------- Keybindings ----------
bindkey -e
bindkey '^ ' autosuggest-accept
# -------------------------
# Minimal Zsh setup
# -------------------------
# Enable completion
autoload -Uz compinit
fpath=(~/.zsh-completions/src $fpath)
compinit

# Syntax highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
source ~/.zsh-autosuggestions/zsh-autosuggestions.zsh

# Colors
autoload -U colors && colors

# -------------------------
# Minimal Prompt
# -------------------------
# First line: full path (greyish brown, 245)
# Second line: λ (greyish blue, 110)
PROMPT='%F{245}%~%f
%F{white}λ %f'

# Autosuggestions faint grey
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Syntax highlight styles
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main)
ZSH_HIGHLIGHT_STYLES[default]='fg=white'
# ZSH_HIGHLIGHT_STYLES[command]='fg=110'       # greyish blue
# ZSH_HIGHLIGHT_STYLES[builtin]='fg=110'       # greyish blue
# ZSH_HIGHLIGHT_STYLES[alias]='fg=110'         # greyish blue
# ZSH_HIGHLIGHT_STYLES[path]='fg=109'          # softer blue-grey
# ZSH_HIGHLIGHT_STYLES[globbing]='fg=109'
# ZSH_HIGHLIGHT_STYLES[comment]='fg=245'       # greyish brown
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=167' # muted red for errors
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#666666'

# ---------- History ----------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups      # don't record duplicate commands
setopt hist_ignore_all_dups
setopt hist_ignore_space     # don't save commands starting with space
setopt inc_append_history    # append to history immediately
setopt share_history         # share history between shells

