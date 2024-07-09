#!/bin/bash

# Arch Linux Development Environment Setup Script

# Update the system
sudo pacman -Syu --noconfirm

# Install base development tools
sudo pacman -S --noconfirm base-devel git

# Install yay (AUR helper)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Install programming languages and compilers
sudo pacman -S --noconfirm ruby gcc nasm python jdk-openjdk go rust dotnet-sdk dotnet-runtime

# Install additional development tools
sudo pacman -S --noconfirm cmake gdb valgrind bash-completion npm yarn postgresql mysql sqlite sed awk curl wget man-db man-pages htop docker docker-compose python-virtualenv nodejs typescript boost qt5 gtk3

# Install IDEs (using yay for AUR packages)
yay -S --noconfirm webstorm rustrover clion pycharm-professional rider rubymine goland intellij-idea-ultimate visual-studio-code-bin

# Install pip and pipenv
sudo pacman -S --noconfirm python-pip
pip install --user pipenv

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker

# Add user to docker group
sudo usermod -aG docker $USER

# Create a scripts directory and add it to PATH
mkdir -p ~/scripts
echo 'export PATH="$HOME/scripts:$PATH"' >> ~/.bashrc

# Install additional useful tools
sudo pacman -S --noconfirm neovim tmux zsh

# Set up Oh My Zsh (optional but recommended)
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Final system update
sudo pacman -Syu --noconfirm

echo "Installation complete! Please log out and log back in for all changes to take effect."
echo "Don't forget to configure your IDEs and tools as needed."
