# slack

Read and answer Slack from Herdr's side panel: direct messages and channels, newest first.
Click one to open it full height, scroll back through its history, reply, and add emoji
reactions. Unread counts and notifications keep working while the panel is closed.

## Install

```sh
cp -R mods/slack ~/.config/herdr-app/mods/
herdr-app check ~/.config/herdr-app/mods/slack
```

The mod runs as two blocks: one that holds the connection and draws nothing, and the
panel. Add both to your layout:

```json
{ "id": "slack-bg", "type": "block", "size": { "px": 0 }, "content": { "mod": "slack", "props": { "bg": true } } },
{ "id": "slack", "type": "block", "content": { "mod": "slack", "props": { "panel": true } } }
```

Put the `bg` block somewhere always in the layout (not inside a stack), and the `panel`
block in your side panel. Opening or closing the panel never reconnects.

## Set up

The panel walks you through it the first time, and whenever Slack rejects a token:

1. **Create the Slack app** from a link that already carries its settings.
2. **App-level token** (`xapp-…`, scope `connections:write`): checked by opening a Socket Mode
   connection.
3. **User token** (`xoxp-…`): checked with `auth.test`; the panel lists which permissions are
   missing and what stops working without them (reacting needs `reactions:write`).
4. Both tokens are saved in `~/.config/herdr-app/data/slack/`, readable by you only
   (`chmod` on macOS and Linux, `icacls` on Windows).

Change tokens or sign out from the gear menu.

## Notes

- One websocket (Socket Mode), pushed events, no polling.
- Slack gives this kind of token no way to mark a conversation read, so "read" is kept in
  Herdr: opening a conversation clears its count here only.
- Other mods can show the unread count: the panel publishes its state in the shared key
  `slack.state`.
