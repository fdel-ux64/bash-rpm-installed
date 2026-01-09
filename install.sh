#!/bin/bash
# Installer for rpm-installed

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Installation directories
INSTALL_DIR="${HOME}/.local/bin"
COMPLETION_DIR="${HOME}/.local/share/bash-completion/completions"

echo "🚀 Installing rpm-installed..."

# Create directories if they don't exist
mkdir -p "$INSTALL_DIR"
mkdir -p "$COMPLETION_DIR"

# Install the main script
if cp bin/rpm-installed "$INSTALL_DIR/rpm-installed"; then
    chmod +x "$INSTALL_DIR/rpm-installed"
    echo -e "${GREEN}✅ Installed rpm-installed to $INSTALL_DIR${NC}"
else
    echo -e "${RED}❌ Failed to install rpm-installed${NC}"
    exit 1
fi

# Install bash completion
if cp completions/rpm-installed.bash "$COMPLETION_DIR/rpm-installed"; then
    echo -e "${GREEN}✅ Installed bash completion to $COMPLETION_DIR${NC}"
else
    echo -e "${YELLOW}⚠️  Warning: Could not install bash completion${NC}"
fi

# Check if install dir is in PATH
if [[ ":$PATH:" != *":$INSTALL_DIR:"* ]]; then
    echo ""
    echo -e "${YELLOW}⚠️  Note: $INSTALL_DIR is not in your PATH${NC}"
    echo "Add this line to your ~/.bashrc or ~/.bash_profile:"
    echo ""
    echo "    export PATH=\"\$HOME/.local/bin:\$PATH\""
    echo ""
fi

# Check if completion will work
if [[ ! -f "$HOME/.bashrc" ]] || ! grep -q "bash-completion" "$HOME/.bashrc" 2>/dev/null; then
    echo ""
    echo -e "${YELLOW}💡 To enable bash completion, ensure these lines are in your ~/.bashrc:${NC}"
    echo ""
    echo "    if [ -f /usr/share/bash-completion/bash_completion ]; then"
    echo "        . /usr/share/bash-completion/bash_completion"
    echo "    fi"
    echo ""
fi

echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
echo ""
echo "Try it out:"
echo "    rpm-installed today"
echo "    rpm-installed count last-week"
echo ""
echo "For help:"
echo "    rpm-installed --help"
