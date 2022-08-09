# Install Nerd Font 
```
install_font(){
    wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/$1.zip
    unzip $1.zip -d ~/.local/share/fonts
    fc-cache -fv
    rm $1.zip
}

install_font UbuntuMono
```

Change font in terminal setting.

# Install NvChad + custom files

```
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
git clone git@github.com:hugolbz/dotfiles.git ~/.config/nvim/lua/custom
nvim +PackerSync
```

# Install support

```
nvim +MasonInstallAll
```

