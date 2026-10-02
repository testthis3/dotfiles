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
alias planify='io.github.alainm23.planify'


# -----------------------------------------------------------------------------
# yt-dlp
# -----------------------------------------------------------------------------

alias audio="yt-dlp -f bestaudio --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s'"


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
# QEMU
# -----------------------------------------------------------------------------

alias qemu-arch='qemu-system-x86_64 \
    -enable-kvm \
    -m 6144 \
    -drive file="$HOME/random/qemu/arch/archlinux.qcow2",media=disk,if=virtio \
    --device virtio-net-pci,netdev=net0 \
    -vga none \
    -device virtio-vga-gl \
    -display gtk,gl=on \
    -netdev user,id=net0 \
    -audiodev driver=pa,id=audio \
    -device ich9-intel-hda \
    -device hda-duplex,audiodev=audio'


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
