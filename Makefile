PREFIX ?= $(HOME)/.local
SYSTEMD_USER_DIR ?= $(HOME)/.config/systemd/user

.PHONY: stow unstow install uninstall enable disable

stow:
	stow --restow --target=$(HOME) .

unstow: disable
	stow --delete --target=$(HOME) .

install:
	install -Dm755 .local/bin/wled-indicator $(DESTDIR)$(PREFIX)/bin/wled-indicator
	install -Dm644 .config/systemd/user/wled-indicator.service $(DESTDIR)$(SYSTEMD_USER_DIR)/wled-indicator.service

uninstall: disable
	rm -f $(DESTDIR)$(PREFIX)/bin/wled-indicator
	rm -f $(DESTDIR)$(SYSTEMD_USER_DIR)/wled-indicator.service

enable:
	systemctl --user daemon-reload
	systemctl --user enable --now wled-indicator

disable:
	-systemctl --user disable --now wled-indicator
