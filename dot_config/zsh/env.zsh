# Path configuration
export PATH="$HOME/.local/bin:$PATH"

# Theme/Prompt (oh-my-posh) - initialized only if the command exists in the environment
if command -v oh-my-posh &>/dev/null; then
    eval "$(oh-my-posh init zsh --config ~/.config/mahiro.omp.json)"
fi
