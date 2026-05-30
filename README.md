# wled-indicator

Linux system tray indicator for [WLED](https://kno.wled.ge/) lights.

Discovers WLED lights on the local network and shows a popup window
from the tray icon.

- **Left-click** a device to toggle on/off
- **Mouse scroll** over a device to adjust brightness
- **Right-click** for a context menu to:
   * pin/unpin important lights to the top of the list
   * keep-alive: keep a light lit only while this indicator is running
   * 1-minute nightlight fades
   * open the Web UI in a browser

Keep-alive is for lights associated with your computer — they stay lit
only while the indicator is running.  They shut down within a minute
when you suspend, shut down, or log out.  Ideal for monitor backlights
and downlights.

Uses the [StatusNotifierItem](https://www.freedesktop.org/wiki/Specifications/StatusNotifierItem/)
D-Bus protocol directly (no libappindicator), with a GtkStatusIcon
fallback for X11 trays (e.g. i3bar).  Works on both X11 and Wayland.

This was created with LLM agent help, but the author is a software engineer, does understand the code, and expects to continue to use and maintain it.  It focuses initially only on my use cases, and has a few rough edges, but requests, suggestions and bugfixes welcome.

## Prerequisites

- [uv](https://docs.astral.sh/uv/) — Python dependencies are handled automatically
- GTK 3 introspection libraries (system packages, see below)
- A system tray — built-in on KDE, XFCE, Cinnamon, Budgie; on GNOME
  you need the [AppIndicator extension](https://extensions.gnome.org/extension/615/appindicator-support/);
  on i3/sway the GtkStatusIcon fallback works with i3bar

```sh
# Ubuntu/Debian (22.04+)
sudo apt install libgirepository1.0-dev libcairo2-dev pkg-config \
    python3-dev gcc gir1.2-gtk-3.0

# Fedora
sudo dnf install gobject-introspection-devel cairo-gobject-devel \
    gcc python3-devel gtk3

# Arch
sudo pacman -S python-gobject gtk3
```

> **Note:** The script pins `PyGObject<3.50` because versions >= 3.50
> require `girepository-2.0`, only available on newer distros (Ubuntu
> 24.04+, Fedora 39+). Remove the pin once your distro provides it.

## Install

The indicator [.local/bin/wled-indicator](.local/bin/wled-indicator) can be executed directly, or installed to run automatically as a user systemd service via `make`:

Installed with [GNU Stow](https://www.gnu.org/software/stow/) (symlinks into `$HOME`):

```sh
make stow enable
```

Or without stow, copy files directly with `install`:

```sh
make install enable
```

## Observe Logs

If enabled as above, logs will go to journald, visible with:

```sh
journalctl --follow --user-unit wled-indicator
```

## Uninstall

```sh
make unstow    # if installed with stow
make uninstall # if installed with install
```

## License

GPLv3 — see [LICENSE](LICENSE).
