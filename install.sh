#!/bin/bash

# 1. Update and install dependencies (Optimized for Ubuntu/Debian)
echo "=> Updating system and installing dependencies..."
sudo apt update
sudo apt install -y zsh git curl neofetch fonts-jetbrains-mono

# 2. Change default shell to Zsh
echo "=> Changing default shell to Zsh..."
sudo chsh -s $(which zsh) $USER

# 3. Install Oh My Zsh
echo "=> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh is already installed."
fi

# 4. Install Plugins & Theme
echo "=> Installing Plugins & Theme..."
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 2>/dev/null || echo "zsh-autosuggestions already exists"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 2>/dev/null || echo "zsh-syntax-highlighting already exists"
git clone https://github.com/zsh-users/zsh-history-substring-search $ZSH_CUSTOM/plugins/zsh-history-substring-search 2>/dev/null || echo "zsh-history-substring-search already exists"

# Theme
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k 2>/dev/null || echo "powerlevel10k already exists"

# 5. Install fzf (Fuzzy Finder for history)
echo "=> Installing fzf..."
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all
else
    echo "fzf is already installed."
fi

# 6. Fetch personal configurations from GitHub
echo "=> Fetching your dotfiles from GitHub (hamadfayyad/zsh_profile)..."
# Assuming your main branch is named 'main'. If it's 'master', change 'main' to 'master' in the links below.
curl -fsSL https://raw.githubusercontent.com/hamadfayyad/zsh_profile/main/.zshrc -o ~/.zshrc
curl -fsSL https://raw.githubusercontent.com/hamadfayyad/zsh_profile/main/.p10k.zsh -o ~/.p10k.zsh

# 7. Add fallback to .bashrc
echo "=> Configuring .bashrc to launch Zsh automatically..."
if [ -f "$HOME/.bashrc" ]; then
    if ! grep -q "exec zsh" "$HOME/.bashrc"; then
        echo "" >> "$HOME/.bashrc"
        echo "# Launch Zsh automatically" >> "$HOME/.bashrc"
        echo 'if [ -t 1 ] && [ -x "$(command -v zsh)" ]; then' >> "$HOME/.bashrc"
        echo '    exec zsh' >> "$HOME/.bashrc"
        echo 'fi' >> "$HOME/.bashrc"
    fi
fi

echo "========================================"
echo "🎉 Setup completed successfully!"
echo "Please restart your terminal or type 'zsh'."
echo "========================================"