#!/usr/bin/env bash
set -e

REPO_RAW="https://raw.githubusercontent.com/lozymon/vscode-settings/main"
VSCODE_USER_DIR="$HOME/.config/Code/User"

echo "==> Installing Cascadia Code font..."
FONT_DIR="$HOME/.local/share/fonts"
if apt-cache show fonts-cascadia-code &>/dev/null; then
  sudo apt-get install -y fonts-cascadia-code
else
  TMP_DIR=$(mktemp -d)
  FONT_URL=$(curl -sL "https://api.github.com/repos/microsoft/cascadia-code/releases/latest" \
    | grep "browser_download_url" | grep "CascadiaCode.zip" | cut -d '"' -f 4)
  curl -sL "$FONT_URL" -o "$TMP_DIR/CascadiaCode.zip"
  unzip -q "$TMP_DIR/CascadiaCode.zip" -d "$TMP_DIR/CascadiaCode"
  mkdir -p "$FONT_DIR"
  find "$TMP_DIR/CascadiaCode" -name "*.ttf" -exec cp {} "$FONT_DIR/" \;
  fc-cache -f "$FONT_DIR"
  rm -rf "$TMP_DIR"
fi
echo "    Done."

echo "==> Copying VSCode settings..."
mkdir -p "$VSCODE_USER_DIR/snippets"
curl -sL "$REPO_RAW/settings.json" -o "$VSCODE_USER_DIR/settings.json"
curl -sL "$REPO_RAW/keybindings.json" -o "$VSCODE_USER_DIR/keybindings.json"
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
