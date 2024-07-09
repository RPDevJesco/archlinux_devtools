#!/bin/bash

# Arch Linux Development Environment Setup Script

# Update the mirrorlist for faster downloads (optional)
sudo pacman -S --noconfirm reflector
sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

# Update the system
sudo pacman -Syu --noconfirm

# Install base development tools
sudo pacman -S --noconfirm base-devel git

# Install yay (AUR helper)
sudo pacman -S --noconfirm --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Install programming languages and compilers
sudo pacman -S --noconfirm ruby gcc nasm python jdk-openjdk go rust dotnet-sdk dotnet-runtime

# Set up environment variables for Go
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export GOROOT=/usr/lib/go' >> ~/.bashrc
echo 'export PATH=$GOPATH/bin:$GOROOT/bin:$PATH' >> ~/.bashrc

# Install additional development tools
sudo pacman -S --noconfirm cmake gdb valgrind bash-completion npm yarn postgresql mysql sqlite sed awk curl wget man-db man-pages htop docker docker-compose python-virtualenv nodejs typescript boost qt5 gtk3

# Install JetBrains Toolbox and VSCode
yay -S --noconfirm jetbrains-toolbox visual-studio-code-bin

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
source ~/.zshrc

# Locale and timezone setup
sudo ln -sf /usr/share/zoneinfo/US/Chicago /etc/localtime
sudo hwclock --systohc
echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen
sudo locale-gen
echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf
echo "KEYMAP=us" | sudo tee /etc/vconsole.conf
echo "ARCH_GDME" | sudo tee /etc/hostname
echo "127.0.0.1 localhost" | sudo tee -a /etc/hosts
echo "::1       localhost" | sudo tee -a /etc/hosts
echo "127.0.1.1 ARCH_GDME.localdomain ARCH_GDME" | sudo tee -a /etc/hosts

# Final system update and cleanup
sudo pacman -Syu --noconfirm
sudo pacman -Scc --noconfirm

echo "Installation complete! Please log out and log back in for all changes to take effect."
echo "After logging back in, launch JetBrains Toolbox to install your preferred IDEs."
echo "Don't forget to configure your IDEs and tools as needed."
