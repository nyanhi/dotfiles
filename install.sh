#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Creating symlinks..."
ln -sfn "${DOTFILES_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
ln -sfn "${DOTFILES_DIR}/.vimrc"     "${HOME}/.vimrc"
ln -sfn "${DOTFILES_DIR}/.zshrc"     "${HOME}/.zshrc"

echo "Symlinks created successfully!"