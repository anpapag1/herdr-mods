#!/bin/sh
# Copies this repo's Herdr mods, layout and theme into the Herdr app home and checks each
# mod. Existing folders and files are skipped unless --force is given.
#
#   ./install.sh            install, keep anything you already have
#   ./install.sh --force    replace existing mods, layout and theme of the same names
#
# HERDR_APP_HOME picks another app home (default ~/.config/herdr-app).
set -eu

here=$(cd "$(dirname "$0")" && pwd)
home_dir=${HERDR_APP_HOME:-"$HOME/.config/herdr-app"}
force=0
[ "${1:-}" = "--force" ] && force=1

if [ ! -d "$home_dir" ]; then
  echo "No Herdr app home at $home_dir. Start the Herdr app once, then run this again." >&2
  exit 1
fi
mkdir -p "$home_dir/mods" "$home_dir/layouts" "$home_dir/themes"

put() { # put <source> <target>
  if [ -e "$2" ] && [ "$force" -eq 0 ]; then
    echo "skip   $2 (exists; --force replaces it)"
    return 1
  fi
  rm -rf "$2"
  cp -R "$1" "$2"
  echo "added  $2"
}

for mod in "$here"/mods/*/; do
  name=$(basename "$mod")
  if put "$mod" "$home_dir/mods/$name"; then
    if command -v herdr-app >/dev/null 2>&1; then
      herdr-app check "$home_dir/mods/$name" >/dev/null 2>&1 \
        && echo "       check passed" \
        || echo "       check FAILED: run herdr-app check $home_dir/mods/$name"
    fi
  fi
done
put "$here/layouts/nightfall.json" "$home_dir/layouts/nightfall.json" || true
put "$here/layouts/nightfall.svg" "$home_dir/layouts/nightfall.svg" || true
put "$here/themes/nightfall.json" "$home_dir/themes/nightfall.json" || true

cat <<MSG

Done. Next:
  herdr-app do layout.switch --name nightfall     # or ctrl-shift-l
  claude plugin marketplace add cybertron288/herdr-mods
  claude plugin install session-info@herdr-mods
  claude plugin install cc-model-router@herdr-mods
Optional: the filetree activity hook, see mods/filetree/README.md.
MSG
