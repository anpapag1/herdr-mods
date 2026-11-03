# session-info

A Claude Code plugin that tracks the session's model, effort, context window and usage:
`ctx` (context used), `5h` and `7d` (rate limits).

- **In a plain terminal** it draws one line under the prompt: ▬ meters, model, effort and
  context size, with the git branch on the right.
- **Inside Herdr** (when `HC_TERMINAL_ID` is set) it draws nothing under the prompt and
  writes the same numbers to `~/.local/state/herdr-session-info/<terminal>.json`, where the
  `session-bar` mod shows them as chips.

It updates when a session starts, when a turn starts and ends, and when usage is measured.

## Install

```sh
claude plugin marketplace add cybertron288/herdr-mods
claude plugin install session-info@herdr-mods
```

Then `/reload-plugins` or restart Claude Code.

## Effort

Shown effort comes from, in order: the effort `cc-model-router` picked (if installed and
on), the effort of the latest model request, the `/config` effort row, the last one shown,
and `effortLevel` in `~/.claude/settings.json`.

## With cc-model-router

Optional. When `cc-model-router` is installed and on, the model shown is the one it picked
and a "routed to" line appears. Without it, nothing changes: `session-info` reads the
router's state only if it exists and never writes it. The two plugins write different files.
