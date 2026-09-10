# .bashrc # If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:/home/marouane/bin
# Created by `pipx` on 2026-07-22 17:10:10
export PATH="$PATH:/home/marouane/.local/bin"


alias ls='ls --color=auto'
alias ll='ls -lh' 
PS1='\W > '



# random
alias p='cd $HOME && source .venv/bin/activate'
alias v='nsxiv' # image viewer 
alias db='export $(dbus-launch)' # to create a dbus session (for obsidian)
alias planify='io.github.alainm23.planify'

# yt-dlp
alias audio="yt-dlp -f bestaudio --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s'"
# flatpak
alias jellyfin='flatpak run org.jellyfin.JellyfinServer'
alias obsidian='flatpak run md.obsidian.Obsidian'
# xbps 
alias i='doas xbps-install -S'
alias u='i; doas xbps-install -u xbps ; doas xbps-install -u'
alias q='doas xbps-query -Rs'
alias r='doas xbps-remove -R'


# qemu
alias qemu-arch='qemu-system-x86_64 \
    -enable-kvm \
    -m 6144 \
    -drive file=/home/marouane//qemu/arch/archlinux.qcow2,media=disk,if=virtio \
    --device virtio-net-pci,netdev=net0 \
    -vga none \
    -device virtio-vga-gl \
    -display gtk,gl=on \
    -netdev user,id=net0 \
    -audiodev driver=pa,id=audio \
    -device ich9-intel-hda \
    -device hda-duplex,audiodev=audio'

cpr() {
    doas rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
}

mvr() {
    doas rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}
