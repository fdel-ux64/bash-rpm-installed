#!/bin/bash
# Uninstaller for rpm-installed

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

INSTALL_DIR="${HOME}/.local/bin"
COMPLETION_DIR="${HOME}/.local/share/bash-completion/completions"
CACHE_FILE="${XDG_CACHE_HOME:-$HOME/.cache}/rpm_installed_cache"

echo "🗑️  Uninstalling rpm-installed..."

# Remove the main script
if [ -f "$INSTALL_DIR/rpm-installed" ]; then
    rm "$INSTALL_DIR/rpm-installed"
    echo -e "${GREEN}✅ Removed rpm-installed from $INSTALL_DIR${NC}"
else
    echo -e "${RED}⚠️  rpm-installed not found in $INSTALL_DIR${NC}"
fi

# Remove bash completion
if [ -f "$COMPLETION_DIR/rpm-installed" ]; then
    rm "$COMPLETION_DIR/rpm-installed"
    echo -e "${GREEN}✅ Removed bash completion${NC}"
fi

# Ask about cache
if [ -f "$CACHE_FILE" ]; then
    read -p "Remove cache file? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm "$CACHE_FILE"
        echo -e "${GREEN}✅ Removed cache file${NC}"
    fi
fi

echo ""
echo -e "${GREEN}🎉 Uninstall complete!${NC}"
