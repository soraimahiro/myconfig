#!/bin/bash

# setup.sh
# Semi-automated setup script for installing Homebrew, fzf, and oh-my-posh.

set -e

echo "=== Starting Environment Setup ==="

# Helper function to print warnings
warn_manual_install() {
    echo "Warning: Unable to automatically install $1. Please install it manually:"
    echo "   - $2"
}

# --- 1. Detect Operating System ---
OS_TYPE="$(uname -s)"
echo "Detected OS: $OS_TYPE"

# --- 2. macOS Setup (with Homebrew) ---
if [[ "$OS_TYPE" == "Darwin" ]]; then
    # Install Homebrew if missing
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Load Homebrew into current subshell session
        if [[ -f "/opt/homebrew/bin/brew" ]]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [[ -f "/usr/local/bin/brew" ]]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    else
        echo "Homebrew is already installed."
    fi

    # Install fzf & oh-my-posh via brew
    echo "Installing fzf and oh-my-posh..."
    brew install fzf oh-my-posh
    echo "Setup complete for macOS!"

# --- 3. Linux Setup ---
elif [[ "$OS_TYPE" == "Linux" ]]; then
    # --- Install fzf ---
    if ! command -v fzf &>/dev/null; then
        echo "Installing fzf..."
        if command -v apt-get &>/dev/null; then
            sudo apt-get update && sudo apt-get install -y fzf
        elif command -v pacman &>/dev/null; then
            sudo pacman -S --noconfirm fzf
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y fzf
        elif command -v yum &>/dev/null; then
            sudo yum install -y fzf
        else
            echo "No supported package manager found. Installing fzf portably via Git..."
            git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
            "$HOME/.fzf/install" --bin --no-update-rc
        fi
    else
        echo "fzf is already installed."
    fi

    # --- Install oh-my-posh ---
    if ! command -v oh-my-posh &>/dev/null; then
        echo "Installing oh-my-posh..."
        # Install portably to ~/.local/bin (no sudo required)
        mkdir -p "$HOME/.local/bin"
        curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$HOME/.local/bin"
    else
        echo "oh-my-posh is already installed."
    fi
    echo "Setup complete for Linux!"

# --- 4. Unsupported OS ---
else
    warn_manual_install "fzf" "https://github.com/junegunn/fzf"
    warn_manual_install "oh-my-posh" "https://ohmyposh.dev"
    exit 1
fi
