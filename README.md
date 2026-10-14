# ◢◤ NOW PLAYING ◥◣

A synthwave terminal "now playing" screen and controller for the
[YouTube Music desktop app](https://github.com/pear-devs/pear-desktop) on Linux.

- Live track info, album art, marquee titles and a [cava](https://github.com/karlstav/cava) visualizer
- Play/pause, next/previous, like/dislike, shuffle, repeat, seek by dragging the time bar
- Search, browse your YouTube Music library and playlists, edit the queue, start radio
- Autoplay: when the queue runs out it keeps going with radio songs
- Fully clickable with the mouse, or use the keyboard
- Falls back to `playerctl` (e.g. YouTube in a browser) when the app isn't running

## Requirements

- Linux with GNOME (the login is read from the GNOME keyring)
- Python 3.10+ with `venv`
- [YouTube Music desktop app](https://github.com/pear-devs/pear-desktop/releases) (`youtube-music` command)
- `cava` and `playerctl`: `sudo apt install cava playerctl`
- A terminal with the kitty graphics protocol for album art. The launcher uses
  [Ghostty](https://ghostty.org); kitty and WezTerm also work if you run `nowplaying` directly.

## Setup

1. **Configure the YouTube Music app** (in the app's menu → Plugins):
   - Enable **API Server** (host `127.0.0.1`, port `26538`, authorization "at first").
   - Enable **Shortcuts (& MPRIS)**.
   - Sign in to your YouTube / Google account in the app.
2. **Install:**
   ```bash
   git clone https://github.com/Chulf58/NowPlaying.git
   cd NowPlaying
   ./install.sh
   ```
   This copies the script to `~/.local/bin/nowplaying`, creates a Python venv in
   `~/.local/share/nowplaying/venv` and adds a "Now Playing" launcher to the app menu.
3. **First start:** open Now Playing. The YouTube Music app shows an
   Allow/Deny dialog. Click **Allow**.

Now Playing starts the YouTube Music app for you and quits it when you close the
last Now Playing window. To keep the app window hidden, close the app and set
`"appVisible": false` and `"tray": false` under `options` in
`~/.config/YouTube Music/config.json`.

## Keys

| Key | Action |
|---|---|
| `space` | play / pause |
| `n` / `p` | next / previous |
| `l` / `d` | like / dislike |
| `s` / `r` | shuffle / repeat |
| `/` | search |
| `b` | library |
| `tab` | queue |
| `c` | cancel loading |
| `q` | quit |

In lists: `enter` open/play, `n` play next, `a` add to queue, `r` radio, `esc` back.

Mouse: everything in the header is clickable. Drag the time bar to seek. Click a
row to select it and click again to play it. The wheel scrolls lists.

## Privacy

Your login is never stored in this project. Now Playing reads it at runtime from
your own YouTube Music app (`~/.config/YouTube Music/Cookies`, decrypted with the
key in your GNOME keyring). The app's API token is saved to
`~/.config/nowplaying/token` (mode 600). Caches and the error log live in
`~/.cache/nowplaying/`.
