# CLI

# Install / Update

- Clone `lets-yak-cli` repo
- In root, `flutter pub global activate -spath . --overwrite`
- Run `yak -h` to test and see available commands

# VSCode Extension

- To update the VSCode extension:
  - Uninstall the extension from the extensions panel
  - Reinstall the extension (sometimes need to do twice)
    - Main branch:
      - Run `yak update --vscode` to update the VSCode package
    - Local Changes:
      - cd into `extensions/vscode` run `npm run build`
      - `cmd+shift+p`
      - Select `Install from VSIX`
      - Select `lets-yak-cli/extensions/vscode/lets-yak.vsix`
        - Note: This file is generated during `npm run build`

## Debug

- Get latest version of npm
  - `npm install npm@latest -g`
- If npm run build not working:
  - `npm install -g typescript`
  - `npm install -g vsce`
  - `npm install`
    - If package not found:
      - Delete package-lock.json
