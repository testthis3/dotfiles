# ~/.bashrc

# -----------------------------------------------------------------------------
# Interactive shell check
# -----------------------------------------------------------------------------

[[ $- != *i* ]] && return


# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export PATH="$HOME/dev/src/programs/llama.cpp/build/bin:$PATH" # llama.cpp commands
export PATH="/usr/local/cuda/bin:$PATH" # nvidia compiler nvcc command
export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"

export PATH="$HOME/.opencode/bin:$PATH" # Opencode command
export PATH="$HOME/.cargo/bin:$PATH" # Rust

export RANGER_LOAD_DEFAULT_RC=false
export VISUAL='vim'
export EDITOR='vim'


# -----------------------------------------------------------------------------
# Prompt
# -----------------------------------------------------------------------------

PS1='\W > '

# -----------------------------------------------------------------------------
# General aliases
# -----------------------------------------------------------------------------

alias ls='ls --color=auto'
alias ll='ls -lh'

alias p='cd "$HOME" && source .venv/bin/activate'
alias v='nsxiv'
alias db='export $(dbus-launch)'

alias config='/usr/bin/git --git-dir=/home/marouane/.cfg/ --work-tree=/home/marouane'

# -----------------------------------------------------------------------------
# yt-dlp
# -----------------------------------------------------------------------------

# Single audio (MP3)
alias yta='yt-dlp -x --audio-format mp3 --audio-quality 0 \
  --embed-metadata --embed-thumbnail --convert-thumbnails jpg \
  --parse-metadata "title:%(title)s" \
  --parse-metadata "artist:%(channel)s" \
  -o "%(title)s.%(ext)s"'

# Single video (MP4)
alias ytv='yt-dlp -f "bv*+ba/b" --merge-output-format mp4 \
  -o "%(title)s.%(ext)s"'

# Playlist audio (MP3)
alias ytpa='yt-dlp -x --audio-format mp3 --audio-quality 0 --yes-playlist \
  --embed-metadata --embed-thumbnail --convert-thumbnails jpg \
  --parse-metadata "title:%(title)s" \
  --parse-metadata "artist:%(channel)s" \
  -o "%(playlist_title)s/%(title)s.%(ext)s"'

# Playlist video (MP4)
alias ytpv='yt-dlp --yes-playlist -f "bv*+ba/b" \
  --merge-output-format mp4 \
  -o "%(playlist_title)s/%(playlist_index)02d - %(title)s.%(ext)s"'

# -----------------------------------------------------------------------------
# Flatpak applications
# -----------------------------------------------------------------------------

alias jellyfin='flatpak run org.jellyfin.JellyfinServer'
alias obsidian='flatpak run md.obsidian.Obsidian'
alias subtitleedit='flatpak run dk.nikse.subtitleedit'


# -----------------------------------------------------------------------------
# XBPS package management
# -----------------------------------------------------------------------------

alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps; doas xbps-install -u'
alias q='doas xbps-query -Rs'
alias r='doas xbps-remove -R'


# -----------------------------------------------------------------------------
# Rsync helpers
# -----------------------------------------------------------------------------

cpr() {
    doas rsync \
        --archive \
        -hh \
        --partial \
        --info=stats1,progress2 \
        --modify-window=1 \
        "$@"
}

mvr() {
    doas rsync \
        --archive \
        -hh \
        --partial \
        --info=stats1,progress2 \
        --modify-window=1 \
        --remove-source-files \
        "$@"
}

# -----------------------------------------------------------------------------
# yazi : make your terminal change to Yazi's last directory when you exit
# -----------------------------------------------------------------------------

function y() {
	local tmp cwd
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


