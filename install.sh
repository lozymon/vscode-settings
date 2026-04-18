#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VSCODE_USER_DIR="$HOME/.config/Code/User"

echo "==> Installing Cascadia Code font..."
FONT_DIR="$HOME/.local/share/fonts"
FONT_URL="https://github.com/microsoft/cascadia-code/releases/latest/download/CascadiaCode.zip"
TMP_DIR=$(mktemp -d)
curl -sL "$FONT_URL" -o "$TMP_DIR/CascadiaCode.zip"
unzip -q "$TMP_DIR/CascadiaCode.zip" -d "$TMP_DIR/CascadiaCode"
mkdir -p "$FONT_DIR"
find "$TMP_DIR/CascadiaCode" -name "*.ttf" -exec cp {} "$FONT_DIR/" \;
fc-cache -f "$FONT_DIR"
rm -rf "$TMP_DIR"
echo "    Done."

echo "==> Copying VSCode settings..."
mkdir -p "$VSCODE_USER_DIR/snippets"
cp "$SCRIPT_DIR/settings.json" "$VSCODE_USER_DIR/settings.json"
cp "$SCRIPT_DIR/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
if [ -d "$SCRIPT_DIR/snippets" ]; then
  cp "$SCRIPT_DIR/snippets/"* "$VSCODE_USER_DIR/snippets/" 2>/dev/null || true
fi
echo "    Done."

echo "==> Installing extensions..."
extensions=(
  "anthropic.claude-code"
  "dbaeumer.vscode-eslint"
  "esbenp.prettier-vscode"
  "aaron-bond.better-comments"
  "waderyan.gitblame"
  "bierner.markdown-mermaid"
  "zhuangtongfa.onedarkpro"
  "humao.rest-client"
  "vscode-icons-team.vscode-icons"
  "christian-kohler.npm-intellisense"
  "github.vscode-github-actions"
  "ms-vscode-remote.remote-containers"
  "usernamehw.errorlens"
  "yoavbls.pretty-ts-errors"
  "gruntfuggly.todo-tree"
  "prisma.prisma"
  "mongodb.mongodb-vscode"
)

for ext in "${extensions[@]}"; do
  echo "    Installing $ext..."
  code --install-extension "$ext" --force 2>/dev/null || echo "    Warning: failed to install $ext"
done

echo ""
echo "Done! Restart VSCode to apply all changes."
