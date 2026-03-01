# exit early if not interactive
[[ -o interactive ]] || return

# environment & path
export TERMINAL='kitty'
# editor
export EDITOR='nvim'
export VISUAL='nvim'

# bat as man pager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export MANROFFOPT="-c"

export MAKEFLAGS="-j$(nproc)"

export PATH="$HOME/.local/bin:$PATH"

# history
HISTSIZE=50000
SAVEHIST=25000
HISTFILE=~/.zsh_history

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY

# oh-my-zsh + starship + plugins

setopt EXTENDED_GLOB

export ZSH="$HOME/.config/oh-my-zsh"
ZSH_THEME=""
DISABLE_AUTO_UPDATE=true

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

plugins=(git archlinux sudo zsh-autosuggestions zsh-syntax-highlighting zsh-shift-select)

source "$ZSH/oh-my-zsh.sh" 2>/dev/null || true

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# bind
bindkey -e

# edit current command in neovim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# history search with up/down arrows
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "${terminfo[kcuu1]:-^[[A}" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]:-^[[B}" history-beginning-search-forward-end

# shell options
setopt INTERACTIVE_COMMENTS
setopt GLOB_DOTS
setopt NO_CASE_GLOB
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# aliases

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -I'
alias ln='ln -v'

alias disk_usage='df -hT /'
alias df='df -hT'

if command -v eza >/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza --icons --group-directories-first -l --git'
    alias la='eza --icons --group-directories-first -la --git'
    alias lt='eza --icons --group-directories-first --tree --level=2'
else
    alias ls='ls --color=auto'
    alias ll='ls -lh'
    alias la='ls -A'
fi

alias diff='delta --side-by-side'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias cat='bat --paging=never'

alias ncdu='gdu'

# use `command sudo nvim ...` to bypass this and call nvim directly
sudo() {
    if [[ "$1" == "nvim" ]]; then
        shift
        if [[ $# -eq 0 ]]; then
            echo "Error: sudoedit requires a filename."
            return 1
        fi
        command sudoedit "$@"
    else
        command sudo "$@"
    fi
}

# yazi
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

mkcd() {
  mkdir -p "$1" && cd "$1"
}

# pacman/expac metrics

# all packages by size
pkg_hogs_all() {
    expac '%m\t%n' | sort -rn | head -n "${1:-20}" | numfmt --to=iec-i --suffix=B --field=1
}

# explicit packages only
pkg_hogs() {
    pacman -Qeq | expac '%m\t%n' - | sort -rn | head -n "${1:-20}" | numfmt --to=iec-i --suffix=B --field=1
}

# recently installed
pkg_new() {
    expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort -r | head -n "${1:-20}"
}

# oldest packages
pkg_old() {
    expac --timefmt='%Y-%m-%d %T' '%l\t%n' | sort | head -n "${1:-20}"
}

# fastfetch on interactive shell open
if command -v fastfetch &>/dev/null; then
    fastfetch
fi

# cache for prompt and tools
_init_cache() {
  local cache="$1" name="$2"
  shift 2
  local bin
  bin="$(command -v "$name")" || return 0
  [[ ! -f "$cache" || "$bin" -nt "$cache" ]] && "$@" >! "$cache"
  source "$cache"
}

_init_cache "$HOME/.starship-init.zsh" starship  starship init zsh --print-full-init
_init_cache "$HOME/.fzf-init.zsh"     fzf        fzf --zsh
_init_cache "$HOME/.zoxide-init.zsh"  zoxide      zoxide init zsh

unset -f _init_cache

# autologin into uwsm hyprland on tty1
if [[ -z "$DISPLAY" ]] && [[ "$(tty)" == "/dev/tty1" ]]; then
  if uwsm check may-start; then
    exec uwsm start hyprland.desktop
  fi
fi
