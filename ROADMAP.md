# mac-config Roadmap

## Ziel

Ein frisch installiertes macOS soll nach minimalem Bootstrap vollständig reproduzierbar eingerichtet werden.

Verwaltet werden sollen:

- Nix / nix-darwin
- Home Manager
- Homebrew
- Mac App Store Apps
- Setapp
- macOS Systemeinstellungen
- Benutzerkonfiguration
- Shell
- Terminal
- Entwicklungswerkzeuge
- Neovim
- Mail-Accounts
- Secrets
- automatische Updates
- Bootstrap für Neuinstallationen

---

## Aktueller Stand

### Basis

- [x] Determinate Nix installiert
- [x] Flake angelegt
- [x] nix-darwin eingerichtet
- [x] Host `MacbookPro`
- [x] Benutzer `jay`
- [x] Home Manager eingebunden
- [x] Repo: `jayzone91/mac-config`

### Neovim

- [x] Neovim Nightly über Nix
- [x] bestehende Config wird verwendet
- [x] `~/.config/nvim` verweist auf `~/Documents/GitHub/nvim`
- [x] nil LSP
- [x] statix
- [x] nixfmt
- [x] Nix-Formatting funktioniert

Neovim-Konfiguration:
`https://github.com/jayzone91/nvim`

### Shell

- [x] Fish installiert
- [x] Fish über Home Manager konfiguriert
- [x] Fish als Login-Shell aktiviert
- [x] Starship aktiviert
- [x] Catppuccin-Starship-Konfiguration
- [x] fzf
- [x] zoxide
- [x] eza
- [x] bat
- [x] fd
- [x] ripgrep

### Ghostty

- [ ] Ghostty-Konfiguration bereinigen
- [ ] Catppuccin Light/Dark
- [ ] Font prüfen/festlegen
- [ ] Padding
- [ ] macOS Titlebar
- [ ] Shell Integration
- [ ] Working Directory übernehmen
- [ ] Clipboard-Verhalten
- [ ] Tabs/Splits
- [ ] Quick Terminal
- [ ] Keybindings
- [ ] Transparenz/Blur prüfen

---

## macOS Systemeinstellungen

Noch vollständig umzusetzen.

### Allgemein

- [ ] Sprache/Region prüfen
- [ ] Zeitzone Europe/Berlin
- [ ] automatische macOS Sicherheitsupdates
- [ ] App Store Updates automatisch
- [ ] Hintergrundupdates
- [ ] Dokumente standardmäßig lokal statt iCloud speichern

### Tastatur

- [ ] schnelle Key Repeat Rate
- [ ] kurze Initial Key Repeat Delay
- [ ] Press-and-Hold deaktivieren
- [ ] Smart Quotes behalten
- [ ] Smart Dashes behalten
- [ ] Rechtschreibkorrektur behalten
- [ ] automatische Großschreibung behalten

Editoren sollen Smart Quotes etc. selbst deaktivieren bzw. nicht verwenden.

### Trackpad

- [ ] Tap to Click
- [ ] Rechtsklick
- [ ] Drei-Finger-Drag prüfen
- [ ] Force Click prüfen
- [ ] Tracking Speed prüfen
- [ ] Scroll-Verhalten prüfen

### Finder

- [ ] Dateiendungen immer anzeigen
- [ ] Pfadleiste anzeigen
- [ ] Statusleiste anzeigen
- [ ] POSIX-Pfad im Titel
- [ ] Suchbereich sinnvoll setzen
- [ ] Warnung beim Ändern von Dateiendungen deaktivieren
- [ ] versteckte Dateien im Finder standardmäßig nicht anzeigen
- [ ] keine `.DS_Store` auf Netzwerkshares
- [ ] keine `.DS_Store` auf USB-Laufwerken
- [ ] externe Datenträger auf Desktop anzeigen
- [ ] Server nicht auf Desktop anzeigen

### Dock

- [ ] Autohide
- [ ] kurze Autohide-Verzögerung
- [ ] kurze Animation
- [ ] keine Recent Apps
- [ ] Minimize into Application
- [ ] feste Dock-Größe
- [ ] gewünschte Apps
- [ ] Downloads/Applications Stack

### Desktop / Mission Control

- [ ] Stage Manager aus
- [ ] Verhalten bei Klick auf Desktop prüfen
- [ ] Widgets-Verhalten
- [ ] Spaces nicht automatisch umsortieren
- [ ] iPad/Sidecar weiterhin möglich
- [ ] Multi-Monitor-spezifische Einstellungen nicht nötig

### Screenshots

- [ ] Zielordner `~/Pictures/Screenshots`
- [ ] PNG oder ggf. anderes Format prüfen
- [ ] Schatten-Verhalten prüfen

### Menüleiste

- [ ] Bartender übernimmt Verwaltung
- [ ] Uhrzeit
- [ ] Datum immer anzeigen

### Sicherheit

- [ ] Firewall aktiv
- [ ] Stealth Mode aktiv
- [ ] Touch ID für sudo
- [ ] FileVault Status prüfen
- [ ] Gatekeeper nicht abschalten
- [ ] TCC-Berechtigungen dokumentieren

### Energie

- [ ] Battery Display Sleep
- [ ] Battery System Sleep
- [ ] Netzbetrieb Display Sleep
- [ ] Netzbetrieb System Sleep
- [ ] Power Nap prüfen
- [ ] Wake on LAN prüfen

---

## Software

### Behalten / installieren

- [ ] Alfred
- [ ] AppCleaner
- [ ] Bloons TD 6+
- [ ] DockDoor
- [ ] Ghostty
- [ ] GitHub Desktop
- [ ] Google Chrome Dev
- [ ] OpenVPN Connect
- [ ] Pages
- [ ] Numbers
- [ ] Keynote
- [ ] Setapp
- [ ] VS Code Stable
- [ ] Windows App
- [ ] AdGuard für Safari

### Setapp

- [ ] Bartender
- [ ] CleanMyMac
- [ ] iBoysoft NTFS
- [ ] Mockuuups Studio
- [ ] Nitro PDF Pro
- [ ] PDF Squeezer

Setapp Login/Aktivierung wird wahrscheinlich teilweise manuell bleiben.

### Entfernen / nicht installieren

- [x] Bionic
- [x] Cork
- [x] Ghostery
- [x] Microsoft Office
- [x] Microsoft Teams
- [x] WhatsApp
- [x] SteuerMac
- [x] Supporter-Modul
- [x] VS Code Insiders
- [x] WakaTime
- [x] Flutter
- [x] Xcode vollständig
- [x] pnpm
- [x] LuaRocks
- [x] sqlc
- [x] PHP
- [x] Composer
- [x] ImageMagick
- [x] cmake als globales Paket
- [x] ninja als globales Paket
- [x] Go Tooling global
- [x] air
- [x] templ
- [x] ginkgo
- [x] mockgen

Xcode Command Line Tools bleiben erforderlich.

---

## Developer Tools

Global:

- [ ] git
- [ ] gh
- [ ] wget
- [ ] jq
- [x] bat
- [x] fd
- [x] ripgrep
- [x] eza
- [x] fzf
- [x] zoxide
- [ ] direnv
- [ ] nix-direnv
- [x] Neovim Nightly
- [ ] tree-sitter-cli
- [ ] Node LTS
- [ ] npm
- [ ] Bun latest
- [ ] Go latest
- [ ] Python latest

Projektabhängige Toolchains sollen in Projekt-Flakes liegen.

---

## Updates

Ziel:

- [ ] tägliche Prüfung
- [ ] `git pull --ff-only`
- [ ] `nix flake update`
- [ ] vollständiger Build
- [ ] nur bei erfolgreichem Build aktivieren
- [ ] Homebrew Update
- [ ] Homebrew Upgrade
- [ ] MAS Updates
- [ ] Cleanup
- [ ] Logging
- [ ] Fehler sollen laufendes System nicht beschädigen

Node:
- aktuelle LTS-Linie

Bun:
- aktuelle stabile Version

Go:
- aktuelle stabile Version

Python:
- aktuelle stabile Version

---

## Homebrew

- [ ] nix-homebrew einbinden
- [ ] Homebrew automatisch installieren
- [ ] Casks deklarativ verwalten
- [ ] Formulae deklarativ verwalten
- [ ] MAS integrieren
- [ ] tägliche Updates

---

## Secrets

Geplant:

- [ ] sops-nix
- [ ] age
- [ ] Bootstrap-Key sicher speichern
- [ ] keine Klartext-Secrets im Repo

Verschlüsseln:

- [ ] Mail-Adressen
- [ ] Mail-Benutzernamen
- [ ] Mail-Passwörter / App-Passwörter
- [ ] ggf. IMAP/SMTP-Hosts
- [ ] Alfred-Lizenz
- [ ] zukünftige API Keys

Mail-Adressen sollen nicht im Klartext im Repository stehen.

---

## Mail

iCloud Mail wird über den Apple Account eingerichtet.

Zusätzliche Accounts:

- ausschließlich IMAP/SMTP
- [ ] Accounts deklarativ beschreiben
- [ ] Daten aus sops laden
- [ ] Konfigurationsprofil erzeugen
- [ ] Mail.app Accounts provisionieren
- [ ] Profilinstallation automatisieren soweit macOS erlaubt

---

## Alfred

- [ ] Installation automatisieren
- [ ] Autostart
- [ ] Preferences über iCloud oder deklarativ
- [ ] Powerpack-Lizenz verschlüsselt speichern
- [ ] unterstützte Aktivierungsmöglichkeiten prüfen
- [ ] Accessibility/TCC bleibt ggf. manuell

---

## Bootstrap

Siehe `bootstrap/README.md`.

Ziel später:

`bootstrap/bootstrap.sh`

Soll:

- [ ] Voraussetzungen prüfen
- [ ] Xcode Command Line Tools installieren
- [ ] Determinate Nix installieren
- [ ] Repo klonen
- [ ] ersten nix-darwin Build durchführen
- [ ] ersten Switch durchführen
- [ ] Fish in `/etc/shells` eintragen
- [ ] Fish als Login-Shell setzen
- [ ] Secrets initialisieren
- [ ] App Store Login voraussetzen/prüfen
- [ ] Setapp vorbereiten
- [ ] manuelle TCC-Schritte ausgeben
- [ ] Abschlussprüfung

### Fish Bootstrap Sonderfall

Der macOS-Benutzer existiert bereits vor nix-darwin.

Daher:

```sh
FISH_PATH="/run/current-system/sw/bin/fish"

grep -qxF "$FISH_PATH" /etc/shells ||
  echo "$FISH_PATH" | sudo tee -a /etc/shells

chsh -s "$FISH_PATH"
```

---

## Bekannte Warnungen

### options.json

Aktuell erscheint beim Build:

```text
Using 'builtins.derivation' to create a derivation named 'options.json' ...
without a proper context.
```

Der Build läuft trotzdem erfolgreich durch.

Die Warnung stammt nicht aus eigener `builtins.derivation`-Logik in diesem Repo.
Bis eine konkrete Ursache in nixpkgs/Home Manager/nix-darwin identifiziert ist,
nicht durch lokale Workarounds unterdrücken.

---

## Repo-Struktur

Geplant:

```text
mac-config/
├── flake.nix
├── flake.lock
├── justfile
├── ROADMAP.md
├── bootstrap/
│   ├── README.md
│   └── bootstrap.sh
├── hosts/
│   └── MacbookPro/
│       └── default.nix
├── home/
│   ├── jay.nix
│   └── modules/
│       ├── shell.nix
│       ├── starship.nix
│       ├── cli.nix
│       ├── neovim.nix
│       └── ghostty.nix
└── modules/
    └── darwin/
        ├── defaults.nix
        ├── security.nix
        ├── homebrew.nix
        ├── updates.nix
        └── mail.nix
```
