# ~/.bashrc

# -----------------------------------------------------------------------------
# Interactive shell check
# -----------------------------------------------------------------------------

[[ $- != *i* ]] && return


# -----------------------------------------------------------------------------
# Environment
# -----------------------------------------------------------------------------

export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

export RANGER_LOAD_DEFAULT_RC=false

#export LIBVIRT_DEFAULT_URI="qemu:///system"

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

alias yta='yt-dlp -x --audio-format mp3 -o "%(title)s.%(ext)s" --add-metadata'
alias ytv='yt-dlp -f "bv*+ba/b" --merge-output-format mp4 -o "%(title)s.%(ext)s"'

# playlist
alias ytpa='yt-dlp -x --audio-format mp3 --yes-playlist -o "%(playlist_title)s/%(title)s.%(ext)s" --add-metadata'
alias ytpv='yt-dlp --yes-playlist -f "bv*+ba/b" --merge-output-format mp4 -o "%(playlist_title)s/%(playlist_index)02d - %(title)s.%(ext)s"'

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
