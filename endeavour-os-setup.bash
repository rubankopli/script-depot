#!/bin/bash

user="$1"

InstallPackages() {
    # Main set of desired packages available via pacman
    local CorePackages=(
        atool
        bandwhich
        bat
        btop
        chezmoi
        curlie
        # delta (as git-delta below)
        difftastic
        distrobox
        docker
        duf
        dust
        entr
        eza
        fd
        fish
        fisher
        fzf
        git
        git-delta
        glances
        grex
        hyperfine
        # jq # via `mise`
        jujutsu
        just
        kitty
        lazygit
        lolcat
        make
        micro
        mise
        # mmv # via AUR
        mtr
        navi
        ncdu
        neovide
        neovim
        nvtop
        obsidian
        ouch
        ov
        pastel
        poppler
        procs
        resvg
        ripgrep
        rust-analyzer
        rustup
        sd
        shellcheck
        snapcast
        syncthing
        tealdeer
        thefuck
        tokei
        trash-cli
        vivid
        wget
        xclip
        yazi
        zellij
        zoxide
    )

    # Packages available only via AUR
    local AURPackages=(
        dotool
        espanso-wayland
        floorp-bin
        localsend-bin
        ov-bin
        snapcast
        sunshine
        vesktop-bin
        viddy
        xivlauncher-bin
    )

    # GUI Packages
    local GUIPackages=(
        moonlight-qt
        steam
    )

    # Packages used by KDE
    local KDEPackages=(
        ksshaskpass
        kwallet-pam
        kwalletmanager
        kwayland-integration
    )

    local Fonts=(
        ttf-anonymouspro-nerd
        ttf-bitstream-vera
        ttf-dejavu
        ttf-hack-nerd
        ttf-intone-nerd
        ttf-jetbrains-mono-nerd
        ttf-liberation
        ttf-lilex-nerd
        ttf-meslo-nerd
        ttf-opensans
        ttf-roboto
        ttf-roboto-mono-nerd
        ttf-sourcecodepro-nerd
        ttf-space-mono-nerd
        ttf-ubuntu-mono-nerd
        ttf-ubuntu-nerd
    )

    pacman --sync --refresh --sysupgrade --noconfirm --needed "${CorePackages[@]}"
    pacman --sync --refresh --sysupgrade --noconfirm --needed "${GUIPackages[@]}"
    pacman --sync --refresh --sysupgrade --noconfirm --needed "${KDEPackages[@]}"
    pacman --sync --refresh --sysupgrade --noconfirm --needed "${Fonts[@]}"

    echo "Install the following via AUR:"
    for package in "${AURPackages[@]}"; do
        echo "$package"
    done
}

SetupFishShell() {
    # Run `fish -c "fisher ..."` to install fisher plugins from plugin file
    fish -c "fisher install \
        jorgebucaran/autopair.fish \
        patrickf1/fzf.fish \
        meaningful-ooo/sponge \
        gazorby/fish-abbreviation-tips \
        ilancosman/tide@v6"

    chsh --shell /usr/bin/fish "$user"
}

# Must be done after package install step so we have chezmoi available!
# SetupConfiguration() {
#     # Run chezmoi
#     chezmoi init --apply https://github.com/rubankopli/dotfiles
#
#     # Apply mise packages
#     mise up
# }

# Package install
# Chezmoi setup (need git ssh?)
# Mise install tools
# Run `fish -c "fisher ..."` to install fisher plugins from plugin file
#   > Remember there is a dotfile conflict when doing this - we should do this prior to chezmoi step
# Run chsh to update user shell to fish
# Install rust toolchain

Main() {
    echo "[BEGINNING USER INSTALL]"
    echo "[Installing Packages]"
    InstallPackages
    echo "[Setting up fish shell]"
    SetupFishShell
}

Main
