#!/usr/bin/env bash
sudo apt update
sudo apt upgrade -y

# install git
sudo apt install -y git

# install curl
sudo apt install -y curl

# install eza for better ls
sudo apt install -y eza

# install net-tools
sudo apt install -y net-tools

# install python
sudo apt install -y python-is-python3
sudo apt install -y python3-pip

# install starship for cli-prettier
curl -sS https://starship.rs/install.sh | sh

# install aws-cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# install eza for better ls
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

# install fnm
curl -fsSL https://fnm.vercel.app/install | bash

# install node
curl -fsSL https://fnm.vercel.app/install | bash
# download and install Node.js
fnm use --install-if-missing 20

# install yubico
# sudo add-apt-repository -y ppa:yubico/stable
# sudo apt-get update
# sudo apt-get install -y libpam-yubico

# install vim
sudo apt install -y vim

cp .vimrc ~/.vimrc
# install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

#install chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

#install nerd font
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/CascadiaCode.zip
mkdir ~/.fonts
unzip CascadiaCode.zip
cp CaskaydiaCoveNerdFontMono-Regular.ttf ~/.fonts
echo "Please set font in terminal profile"

# Copy config files
cp ./linux/starship.toml ~/.config/
sudo cp ./linux/ram_usage /usr/local/bin/
sudo chmod +x /usr/local/bin/ram_usage

cat .bash_profile >> ~/.bashrc
source ~/.bashrc

