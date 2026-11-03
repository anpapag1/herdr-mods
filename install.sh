#!/bin/sh
# Copies every Herdr mod in this repo (each <folder>/mods/<name>/) into the Herdr app home,
# checks each one, and installs session-bar's Claude Code plugin. Existing mods are skipped
# unless --force is given.
#
#   ./install.sh            install, keep anything you already have
#   ./install.sh --force    replace existing mods of the same names
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
mkdir -p "$home_dir/mods"

done_list=" "
for mod in "$here"/*/mods/*/; do
  name=$(basename "$mod")
  # filetree's folder carries file-icons too; copy each mod once.
  case "$done_list" in *" $name "*) continue ;; esac
  done_list="$done_list$name "
  target="$home_dir/mods/$name"
  if [ -e "$target" ] && [ "$force" -eq 0 ]; then
    echo "skip   $target (exists; --force replaces it)"
    continue
  fi
  rm -rf "$target"
  cp -R "$mod" "$target"
  echo "added  $target"
  if command -v herdr-app >/dev/null 2>&1; then
    herdr-app check "$target" >/dev/null 2>&1 \
      && echo "       check passed" \
      || echo "       check FAILED: run herdr-app check $target"
  fi
done

# session-bar's other half runs inside Claude Code and sends it Claude's numbers.
if command -v claude >/dev/null 2>&1; then
  claude plugin marketplace add "$here" >/dev/null 2>&1 \
    || claude plugin marketplace update herdr-mods >/dev/null 2>&1 || true
  if claude plugin install session-bar@herdr-mods >/dev/null 2>&1; then
    echo "added  Claude Code plugin session-bar@herdr-mods"
  else
    echo "       Claude Code plugin FAILED: run claude plugin install session-bar@herdr-mods"
  fi
else
  echo "skip   Claude Code plugin session-bar (no claude command; see session-bar/README.md)"
fi

cat <<MSG

Done. Next:
  put the mods in your layout; each folder's README.md shows its block
  restart Claude Code sessions so the session-bar plugin loads
Optional: claude plugin install cc-model-router@herdr-mods
Optional: the filetree activity hook, see filetree/README.md.
MSG
