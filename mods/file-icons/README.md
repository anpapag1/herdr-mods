# file-icons

Herdr's Files panel with the icons of VS Code's Material Icon Theme: a lazy file browser for
the focused terminal's folder with git marks and read-only previews.

It is also the icon set for `filetree`, which draws from `mods/file-icons/icons/`. Install it
whenever you use `filetree`, even if you don't show this panel.

## Install

```sh
cp -R mods/file-icons ~/.config/herdr-app/mods/
herdr-app check ~/.config/herdr-app/mods/file-icons
```

To use it as your Files panel:

```json
{ "id": "files", "type": "block", "content": { "mod": "file-icons" } }
```

## Contents

- `icons/`: about 1,180 SVG icons.
- `icons.js`: which icon each file name, extension and folder name gets.
- `LICENSE-material-icon-theme.txt`: the icons' MIT licence.

Based on Herdr's own `files` mod (Apache-2.0).
