# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# OMZ Config
DISABLE_AUTO_TITLE="true"

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_save_no_dups

# Plugin Config
plugins=(git fzf-tab)

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $ZSH/oh-my-zsh.sh

# User Config
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Prompt: Starship + Custom new line
eval "$(starship init zsh)"

typeset -g _first_prompt=false

precmd() {
  if $_first_prompt; then
    echo ""
  else
    _first_prompt=true
  fi
}

function clear() {
  command clear
  _first_prompt=false
}

# Fzf
source <(fzf --zsh)
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#2d3f76 \
  --color=bg:#1e2030 \
  --color=border:#589ed7 \
  --color=fg:#c8d3f5 \
  --color=gutter:#1e2030 \
  --color=header:#ff966c \
  --color=hl+:#65bcff \
  --color=hl:#65bcff \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#65bcff \
  --color=query:#c8d3f5:regular \
  --color=scrollbar:#589ed7 \
  --color=separator:#ff966c \
  --color=spinner:#ff007c \
"
# Lazy load conda
lazy_conda_aliases=('python' 'conda')

load_conda() {
  for lazy_conda_alias in "${lazy_conda_aliases[@]}"
  do
    unalias $lazy_conda_alias 2>/dev/null
  done

  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/Users/baonguyen7/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/Users/baonguyen7/miniconda3/etc/profile.d/conda.sh" ]; then
          . "/Users/baonguyen7/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="/Users/baonguyen7/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<

  unfunction load_conda
}

for lazy_conda_alias in "${lazy_conda_aliases[@]}"
do
  alias $lazy_conda_alias="load_conda && $lazy_conda_alias"
done

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/baonguyen7/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/baonguyen7/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/baonguyen7/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/baonguyen7/google-cloud-sdk/completion.zsh.inc'; fi
