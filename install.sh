#!/bin/bash

# =============================================================================
# Jai's Modern Arch Linux Dotfiles Installer
# Targets: Arch Linux with Hyprland + Rebos + Chezmoi + Oh My Zsh
# =============================================================================

set -e

# --- Colors & Styles ---
BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

# --- Configuration ---
REPO_URL="https://github.com/jaintp/dotfiles.git"
LOG_FILE="/tmp/dotfiles-install.log"

# --- Helper Functions ---
print_header() {
    clear
    echo -e "${BOLD}${MAGENTA}"
    echo "      JaINTP's Dotfiles      "
    echo -e "   [ Modern Arch Linux Stack ]${RESET}"
    echo -e "----------------------------------------"
    echo -e "  Log: ${BOLD}${LOG_FILE}${RESET}"
    echo -e "----------------------------------------"
}

print_step() {
    echo -e "\n${BOLD}${BLUE}==>${RESET} ${BOLD}$1${RESET}"
}

print_success() {
    echo -e "${GREEN}${BOLD} [ OK ]${RESET} $1"
}

print_info() {
    echo -e "${BLUE}${BOLD} [ INFO ]${RESET} $1"
}

print_error() {
    echo -e "${RED}${BOLD} [ ERROR ]${RESET} $1"
    exit 1
}

# --- 0. Pre-flight Checks ---
print_header
print_step "Performing pre-flight checks..."

if [ ! -f /etc/arch-release ]; then
    print_error "This script is designed for Arch Linux only."
fi

if ! ping -c 1 google.com &>/dev/null; then
    print_error "No internet connection detected."
fi

if ! sudo -v &>/dev/null; then
    print_error "Sudo access is required for installation."
fi

print_success "Pre-flight checks passed."

# --- 1. System Update & Zsh ---
print_step "Updating system and installing core dependencies..."
print_info "Installing zsh, git, and base-devel..."
sudo pacman -Syu --needed --noconfirm base-devel git zsh | tee -a "$LOG_FILE"
print_success "Core dependencies installed."

# --- 2. Oh My Zsh ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_step "Installing Oh My Zsh..."
    print_info "Oh My Zsh provides a framework for managing your Zsh configuration."
    # Use the unattended install flag to prevent it from switching to a sub-shell immediately
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended | tee -a "$LOG_FILE"
    print_success "Oh My Zsh installed."
else
    print_info "Oh My Zsh is already installed. Skipping."
fi

# --- 4. Dotfile Manager (chezmoi) ---
print_step "Installing and running 'chezmoi'..."
if ! command -v chezmoi &> /dev/null; then
    print_info "Installing chezmoi via pacman..."
    sudo pacman -S --noconfirm chezmoi | tee -a "$LOG_FILE"
fi

print_info "Initializing and applying dotfiles from ${REPO_URL}..."
# Use --force to ensure we overwrite any default files (like .zshrc)
# This will prompt for variables defined in .chezmoi.toml.tmpl
chezmoi init --apply --force "$REPO_URL" | tee -a "$LOG_FILE"
print_success "chezmoi is ready and dotfiles are applied."

# --- 5. AUR Helper (yay) ---
if ! command -v yay &> /dev/null; then
    print_step "Installing 'yay' (AUR helper)..."
    TEMP_DIR=$(mktemp -d)
    git clone https://aur.archlinux.org/yay.git "$TEMP_DIR"
    cd "$TEMP_DIR"
    makepkg -si --noconfirm | tee -a "$LOG_FILE"
    cd -
    rm -rf "$TEMP_DIR"
    print_success "yay is ready."
else
    print_info "yay is already installed. Skipping."
fi

# --- 6. Rebos (Package Management) ---
print_step "Installing 'rebos-git'..."
yay -S --noconfirm rebos-git | tee -a "$LOG_FILE"
print_success "rebos is ready."

# --- 7. Sync System State ---
print_step "Synchronizing system state with rebos..."
print_info "Initializing rebos setup..."
rebos setup | tee -a "$LOG_FILE"

# Verify that chezmoi correctly placed the rebos config
if [ ! -f "$HOME/.config/rebos/gen.toml" ]; then
    print_error "Rebos configuration (gen.toml) not found in ~/.config/rebos/. Did chezmoi apply fail?"
fi

print_info "Committing initial generation..."
rebos gen commit "Initial machine install" | tee -a "$LOG_FILE"
print_success "System state synchronized."

# --- 8. Set Shell ---
print_step "Setting Zsh as the default shell..."

# Find a valid zsh path that exists in /etc/shells
ZSH_PATH=""
for p in "/usr/bin/zsh" "/bin/zsh" "$(which zsh 2>/dev/null)"; do
    if [ -n "$p" ] && grep -qxF "$p" /etc/shells; then
        ZSH_PATH="$p"
        break
    fi
done

if [ -z "$ZSH_PATH" ]; then
    print_error "Could not find a valid zsh path in /etc/shells."
fi

# Get current shell from /etc/passwd for the current user
CURRENT_USER_SHELL=$(getent passwd "$USER" | cut -d: -f7)

if [ "$CURRENT_USER_SHELL" != "$ZSH_PATH" ]; then
    print_info "Changing shell from $CURRENT_USER_SHELL to $ZSH_PATH..."
    sudo chsh -s "$ZSH_PATH" "$USER" | tee -a "$LOG_FILE"
    print_success "Default shell changed to Zsh."
else
    print_info "Zsh is already the default shell ($ZSH_PATH)."
fi

# --- Final Summary ---
echo -e "\n${BOLD}${GREEN}========================================${RESET}"
echo -e "${BOLD}${GREEN}      INSTALLATION COMPLETE!${RESET}"
echo -e "${BOLD}${GREEN}========================================${RESET}"
echo -e " Your environment is fully configured."
echo -e ""
echo -e "${BOLD}Next Steps:${RESET}"
echo -e " 1. Your shell is now ${BOLD}zsh${RESET} with the ${BOLD}jaintp${RESET} theme."
echo -e " 2. Restart your session or run 'zsh' to see the changes."
echo -e " 3. Enter ${BOLD}Hyprland${RESET} whenever you're ready."
echo -e ""
echo -e "${BOLD}Management commands:${RESET}"
echo -e " ${BLUE}•${RESET} Update Dotfiles:  ${BOLD}chezmoi update && chezmoi apply${RESET}"
echo -e " ${BLUE}•${RESET} Update Packages:  ${BOLD}rebos gen commit \"Your message\"${RESET}"
echo -e " ${BLUE}•${RESET} Add new config:   ${BOLD}chezmoi add ~/.config/your-app/config${RESET}"
echo -e "----------------------------------------\n"
