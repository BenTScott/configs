#!/bin/bash
set -euxo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install homebrew
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Install brew packages
brew install nvim fzf ripgrep mise direnv zsh-autosuggestions zsh-syntax-highlighting thefuck delta htop

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
fi

# Symlink configs
mkdir -p ~/.config/mise
ln -sf "$SCRIPT_DIR/nvim" ~/.config/nvim
ln -sf "$SCRIPT_DIR/.tmux.conf" ~/.tmux.conf
ln -sf ~/configs/.gitconfig ~/.gitconfig
ln -sf "$SCRIPT_DIR/mise/global.toml" ~/.config/mise/config.toml
ln -sf "$SCRIPT_DIR/.zshrc.local" ~/.zshrc.local

# Symlink scripts to ~/bin
mkdir -p ~/bin
ln -sf "$SCRIPT_DIR/scripts" ~/bin/scripts

# TMUX plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Configure zsh
sed -i 's/^plugins=(.*/plugins=(git aliases aws fzf ssh thefuck vi-mode)/' ~/.zshrc
grep -q 'source ~/.zshrc.local' ~/.zshrc || echo 'source ~/.zshrc.local' >> ~/.zshrc

echo "Done! Start a new zsh session to use your config."
