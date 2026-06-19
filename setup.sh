#!/bin/bash
set -euxo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install homebrew
echo "Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install brew packages
brew install nvim fzf tmux ripgrep mise direnv zsh-autosuggestions zsh-syntax-highlighting

# Install oh-my-zsh (don't let it launch a new shell)
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended

# Symlink configs
mkdir -p ~/.config/mise
ln -s "$SCRIPT_DIR/nvim" ~/.config/nvim
ln -s "$SCRIPT_DIR/tmux/.tmux.conf" ~/.tmux.conf
ln -s "$SCRIPT_DIR/mise/config.toml" ~/.config/mise/config.toml
ln -s "$SCRIPT_DIR/.zshrc.local" ~/.zshrc.local

# Symlink scripts to ~/bin
mkdir -p ~/bin
for script in "$SCRIPT_DIR"/scripts/*; do
  ln -s "$script" ~/bin/
done

# TMUX plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Configure zsh
sed -i 's/^plugins=(.*/plugins=(git aliases aws fzf ssh thefuck vi-mode)/' ~/.zshrc
echo 'source ~/.zshrc.local' >> ~/.zshrc

echo "Done! Start a new zsh session to use your config."
