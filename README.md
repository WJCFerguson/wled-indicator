# wled-indicator

Linux system tray indicator for [WLED](https://kno.wled.ge/) lights.

Discovers WLED lights on the local network and offers quick control
from a tray menu.

- **Left-click** a device to toggle on/off
- **Mouse Scroll** over a device to adjust brightness
- **Right-click** for a menu to:
   * pin/unpin important lights to the top of the list
   * keep-alive: keep a light lit only while this indicator is running
   * some 1-minute nightlight fades
   * open the Web UI in a browser

Keep-alive is functionality for lights associated with your computer, to keep them lit only while the indicator is running.  They will shut down within a minute when you suspend, shut down, or log out etc..  This is ideal for backlights and downlights on a monitor.

This was created with LLM agent help, but the author is a software engineer, does understand the code, and expects to continue to use and maintain it.  It focuses initially only on my use cases, and has a few rough edges, but requests, suggestions and bugfixes welcome.

## Prerequisites

- [uv](https://docs.astral.sh/uv/) — Python dependencies are handled automatically
- GTK 3 introspection libraries and AppIndicator typelibs (system packages, see below)
- A system tray — most DEs have one; on GNOME you may need the
  [AppIndicator extension](https://extensions.gnome.org/extension/615/appindicator-support/)

```sh
# Ubuntu/Debian (22.04+)
sudo apt install libgirepository1.0-dev libcairo2-dev pkg-config \
    python3-dev gcc gir1.2-gtk-3.0 gir1.2-ayatanaappindicator3-0.1

# Fedora
sudo dnf install gobject-introspection-devel cairo-gobject-devel \
    gcc python3-devel gtk3 libayatana-appindicator-gtk3

# Arch
sudo pacman -S python-gobject gtk3 libappindicator-gtk3
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
