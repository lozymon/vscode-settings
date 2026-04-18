# VSCode Settings

My personal VSCode configuration for Linux.

## What's included

- `settings.json` — editor preferences, theme, fonts, formatting
- `extensions.json` — recommended extensions
- `keybindings.json` — custom keybindings
- `snippets/` — custom code snippets
- `install.sh` — installs everything in one shot

## Install

```bash
curl -sL https://raw.githubusercontent.com/lozymon/vscode-settings/main/install.sh | bash
```

The script will:

1. Download and install the **Cascadia Code** font
2. Copy `settings.json` and `keybindings.json` to `~/.config/Code/User/`
3. Copy snippets to `~/.config/Code/User/snippets/`
4. Install all extensions via `code --install-extension`

Restart VSCode after running.

## Extensions

| Extension                | ID                                   |
| ------------------------ | ------------------------------------ |
| Claude Code              | `anthropic.claude-code`              |
| ESLint                   | `dbaeumer.vscode-eslint`             |
| Prettier                 | `esbenp.prettier-vscode`             |
| Better Comments          | `aaron-bond.better-comments`         |
| Git Blame                | `waderyan.gitblame`                  |
| Markdown Preview Mermaid | `bierner.markdown-mermaid`           |
| One Dark Pro             | `zhuangtongfa.onedarkpro`            |
| REST Client              | `humao.rest-client`                  |
| VSCode Icons             | `vscode-icons-team.vscode-icons`     |
| npm Intellisense         | `christian-kohler.npm-intellisense`  |
| GitHub Actions           | `github.vscode-github-actions`       |
| Remote Containers        | `ms-vscode-remote.remote-containers` |
| Error Lens               | `usernamehw.errorlens`               |
| Pretty TS Errors         | `yoavbls.pretty-ts-errors`           |
| Todo Tree                | `gruntfuggly.todo-tree`              |
| Prisma                   | `prisma.prisma`                      |
| MongoDB                  | `mongodb.mongodb-vscode`             |

## Requirements

- Linux (Debian/Ubuntu)
- VSCode installed and `code` available in PATH
- `curl`, `unzip`, `fc-cache` available
