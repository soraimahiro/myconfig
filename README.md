# myconfig

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/).

---

## Requirements and Setup

This configuration depends on the following tools:
*   Homebrew (on macOS)
*   fzf (for fuzzy-finding and completion)
*   oh-my-posh (for prompt rendering)

You can install all of them automatically by running the setup script after applying your configuration:

1.  Initialize and apply chezmoi:
    ```bash
    chezmoi init git@github.com:soraimahiro/myconfig.git
    chezmoi apply
    ```
2.  Run the setup script to install dependencies:
    ```bash
    ~/setup.sh
    ```

---

## Repository Structure

*   **`.zshrc`**: The main bootstrap file that loads both the modular config files and your local hook file.
*   **`.config/zsh/`**: Modular shell configurations:
    *   `env.zsh`: Safe PATH adjustments and environment setup.
    *   `plugins.zsh`: Bootstraps Zinit and loads plugins/snippets.
    *   `config.zsh`: Auto-completion styles (`zstyle`) and zsh options.
    *   `aliases.zsh`: Handy shortcuts and aliases (e.g. `makecpp`).
*   **`.config/Code/User/settings.json`**: VS Code user settings (linked from `~/Library/Application Support/Code/User/` on macOS).
*   **`.config/zellij/`**: Zellij multiplexer settings.
*   **`.wezterm.lua`**: Wezterm terminal configuration.
*   **`.tmux.conf`**: TMUX terminal multiplexer settings.
*   **`.gitconfig`**: Global Git preferences.
*   **`setup.sh`**: The setup script for installing dependencies.

---

## Local Configurations

Any machine-specific configurations (like Homebrew initializations, private API keys, local proxies, or settings automatically appended by installers) should be placed in:

*   **`~/.zshrc.local`** (not tracked by chezmoi)

This file is sourced at the very beginning of `.zshrc` so it is loaded before any plugin managers or themes are initialized.
