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

- Linux with GNOME, e.g. Ubuntu (the login is read from the GNOME keyring)
- Python 3.10 or newer (Ubuntu has it already)
- The YouTube Music desktop app
- `cava`, `playerctl` and `git`
- The Ghostty terminal, for the launcher and album art. kitty and WezTerm also
  work if you run `nowplaying` from them yourself.

## Setup (step by step)

### 1. Install the programs it needs

Open a terminal and run:

```bash
sudo apt install git python3-venv cava playerctl
sudo snap install ghostty --classic
```

### 2. Install the YouTube Music app

1. Go to <https://github.com/pear-devs/pear-desktop/releases/latest>.
2. Under **Assets**, download `youtube-music_<version>_amd64.deb`.
3. Install it (in the folder you downloaded it to):
   ```bash
   sudo apt install ./youtube-music_*_amd64.deb
   ```

### 3. Set up the YouTube Music app

1. Open **YouTube Music** from the app menu.
2. Sign in to your Google / YouTube account in the app.
3. In the menu bar at the top of the window (press `Alt` if you can't see it),
   open **Plugins** and turn on:
   - **API Server**. Keep the defaults: host `127.0.0.1`, port `26538`,
     authorization "at first".
   - **Shortcuts (& MPRIS)**
4. Close the app.

### 4. Install Now Playing

```bash
git clone https://github.com/Chulf58/NowPlaying.git
cd NowPlaying
./install.sh
```

This copies the script to `~/.local/bin/nowplaying`, creates a Python venv in
`~/.local/share/nowplaying/venv` and adds **Now Playing** to the app menu.

### 5. First start

1. Open **Now Playing** from the app menu. It starts YouTube Music for you.
2. YouTube Music asks whether to allow "nowplaying". Click **Allow**.
3. If your computer asks to unlock the keyring, enter your login password. This
   lets Now Playing read the app's login for your library and playlists.

Now Playing quits YouTube Music when you close the last Now Playing window.

**Optional: keep the YouTube Music window hidden.** Close the app, open
`~/.config/YouTube Music/config.json` and set `"appVisible": false` and
`"tray": false` under `options`. To sign in again later, use
**Library › Sign in** in Now Playing, which shows the app window.

## Updating

Now Playing checks GitHub for a new version when it starts (and every 6 hours
while it runs). When there is one, it asks **"A new update is available. Do you
want to download it?"**. Click **Yes, download** (or press `y`) and it downloads
and installs the new version, then offers to restart. Click **No** (or press
`n`) and it asks again the next time you start it.

If you installed a version without the update check, update by hand once:

```bash
cd NowPlaying
git pull
./install.sh
```

## Troubleshooting

- **The library says you're not signed in:** sign in in the YouTube Music app
  (Library › Sign in in Now Playing opens it).
- **You clicked Deny, or it keeps asking for permission:** close Now Playing,
  run `rm ~/.config/nowplaying/token`, and start it again.
- **No visualizer:** check that `cava` is installed.
- **An update failed:** look in `~/.cache/nowplaying/update.log`, or update by hand
  (see Updating).
- **Something else went wrong:** look in `~/.cache/nowplaying/error.log`.

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
