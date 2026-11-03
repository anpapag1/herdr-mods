# herdr-mods

Mods for the [Herdr app](https://herdr.dev), the desktop window for terminals and coding
agents, plus two Claude Code plugins that feed them. Every mod takes its colors from the
active theme, so it fits any layout.

Each folder is one mod as [herdr.dev/mods](https://herdr.dev/mods) lists it:
`<name>/mods/<name>/` (the mod), `RECIPE.md` (the brief an agent can rebuild it from),
`preview.png` and a `README.md`.

## Mods

| Mod | What it does | Add it |
|---|---|---|
| [filetree](filetree) | File tree with Tree and Recent views, git status, search, previews, and Claude's reads and writes lit up | [herdr.dev/mods/cybertron288/filetree](https://herdr.dev/mods/cybertron288/filetree) |
| [file-icons](file-icons) | A Files panel with Material Icon Theme icons; also the icon set filetree uses | [herdr.dev/mods/cybertron288/file-icons](https://herdr.dev/mods/cybertron288/file-icons) |
| [session-bar](session-bar) | Bottom bar of chips: folder, branch, ↑ ↓, changed, staged, stashes, and Claude's model, effort, router and usage | [herdr.dev/mods/cybertron288/session-bar](https://herdr.dev/mods/cybertron288/session-bar) |
| [run-scripts](run-scripts) | Run control for JavaScript projects: pick a `package.json` script and run it in a new tab | [herdr.dev/mods/cybertron288/run-scripts](https://herdr.dev/mods/cybertron288/run-scripts) |
| [ci-dash](ci-dash) | CI runs: GitHub Actions for the repo you're in, with dispatch and artifacts. Based on dougcunha's ci-dash-app | [herdr.dev/mods/cybertron288/ci-dash](https://herdr.dev/mods/cybertron288/ci-dash) |
| [slack](slack) | Read and answer Slack in the side panel | [herdr.dev/mods/cybertron288/slack](https://herdr.dev/mods/cybertron288/slack) |
| [yt-music](yt-music) | Now playing and controls for YouTube Music in Chrome (macOS) | [herdr.dev/mods/cybertron288/yt-music](https://herdr.dev/mods/cybertron288/yt-music) |

The Nightfall layout that puts them all together lives in its own repo,
[herdr-nightfall](https://github.com/cybertron288/herdr-nightfall).

## A closer look

[![filetree](docs/screenshots/filetree.png)](filetree)

[![session-bar](docs/screenshots/session-bar.png)](session-bar)

[![run-scripts](docs/screenshots/run-scripts.png)](run-scripts)

[![ci-dash](docs/screenshots/ci-dash.png)](ci-dash)

[![slack](docs/screenshots/slack.png)](slack)

[![yt-music](docs/screenshots/yt-music.png)](yt-music)

[![file-icons](docs/screenshots/file-icons.png)](file-icons)

[![cc-model-router](docs/screenshots/cc-model-router.png)](claude-plugins/cc-model-router)

The screenshots use made-up projects, people and numbers.

## Install

### One mod, with your agent

Paste this into Claude Code (or any agent) inside Herdr, with the mod's name:

```text
Read ~/.config/herdr-app/AGENTS.md, then add this mod: herdr.dev/mods/cybertron288/<name>
```

The agent reads the mod, tells you what it touches, copies it into
`~/.config/herdr-app/mods/` and checks it. Each mod's README says which layout block it
fits.

### Everything, with the script

```sh
git clone https://github.com/cybertron288/herdr-mods.git
cd herdr-mods
./install.sh            # copies every mod into ~/.config/herdr-app/mods
```

The script skips any mod you already have and says so; `--force` replaces them. It runs
`herdr-app check` on every mod it copies, and installs session-bar's Claude Code plugin
when the `claude` command is on your PATH.

### One mod by hand

```sh
cp -R run-scripts/mods/* ~/.config/herdr-app/mods/
herdr-app check ~/.config/herdr-app/mods/run-scripts
```

Every mod has `"place": "none"`, so it appears only where a layout puts it, or where you
open it:

```sh
herdr-app do pane.split --direction right --mod filetree
herdr-app do tab.new --name CI --mod ci-dash
```

## Claude Code plugins

This repo is also a Claude Code plugin marketplace:

```sh
claude plugin marketplace add cybertron288/herdr-mods
claude plugin install session-bar@herdr-mods
claude plugin install cc-model-router@herdr-mods
```

| Plugin | What it does |
|---|---|
| [`session-bar`](session-bar/claude-plugin) | The Claude Code half of the session-bar mod: sends model, effort, context window and usage to the bar. |
| [`cc-model-router`](claude-plugins/cc-model-router) | Routes each prompt to Haiku, Sonnet or Opus by how hard it is. `/router on`, `off`, `status`. Shows as the Router chip in session-bar. |

The two plugins are independent: each writes its own file
(`~/.local/state/herdr-session-bar/` and `~/.local/state/herdr-model-router/`), and
session-bar only reads the router's state when the router is installed. Restart Claude
Code sessions, or run `/reload-plugins`, after installing. If you have these plugins from
another marketplace, or the older `session-info` plugin, disable those first.

## Where things live

| Path | What |
|---|---|
| `~/.config/herdr-app/mods/<name>/` | the Herdr mods |
| `~/.config/herdr-app/data/<mod>/` | mod state Herdr keeps (Slack tokens, YT Music state) |
| `~/.local/state/herdr-session-bar/<terminal>.json` | what the session-bar plugin sends to the mod |
| `~/.local/state/herdr-model-router/<terminal>.json` | what cc-model-router sends to session-bar |
| `~/.local/state/herdr-filetree/activity.jsonl` | Claude's file activity for filetree |

## Licence

MIT, see [LICENSE](LICENSE). Some mods include or adapt open-source work; their notices are
in [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).
