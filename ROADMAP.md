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
- [x] Konfiguration in Home- und Darwin-Module aufgeteilt
- [x] `justfile` angelegt
- [x] `just check`
- [x] `just build`
- [x] `just apply`
- [x] `just update`
- [x] `just fmt`
- [x] `just status`
- [x] `just gc`

### Neovim

- [x] Neovim Nightly über Nix
- [x] bestehende Config wird verwendet
- [x] `~/.config/nvim` verweist auf `~/Documents/GitHub/nvim`
- [x] nil LSP
- [x] statix
- [x] nixfmt
- [x] Nix-Formatting funktioniert
- [x] Neovim als eigenes Home-Manager-Modul ausgelagert

Neovim-Konfiguration:

`https://github.com/jayzone91/nvim`

### Shell

- [x] Fish installiert
- [x] Fish über Home Manager konfiguriert
- [x] Fish als Login-Shell aktiviert
- [x] Fish-Bootstrap-Sonderfall dokumentiert
- [x] Starship aktiviert
- [x] Catppuccin-Starship-Konfiguration
- [x] fzf
- [x] zoxide
- [x] eza
- [x] bat
- [x] fd
- [x] ripgrep
- [x] Shell-Konfiguration modularisiert

### Ghostty

- [x] Ghostty-Konfiguration über Home Manager
- [x] Ghostty als eigenes Modul
- [x] Catppuccin Light/Dark
- [x] Standard-Font funktioniert inkl. Nerd-Font-Symbole
- [x] Padding
- [x] macOS Titlebar
- [x] Shell Integration
- [x] Working Directory bei Fenstern/Tabs/Splits übernehmen
- [x] Clipboard-Verhalten
- [x] Tabs/Splits
- [x] Quick Terminal
- [x] globaler Shortcut `Ctrl+Shift+Space`
- [x] deutsche Tastatur berücksichtigt
- [x] linke Option-Taste als Alt
- [x] Accessibility/TCC für globalen Shortcut eingerichtet
- [ ] Transparenz/Blur optional prüfen

---

## macOS Systemeinstellungen

Die wesentlichen Systemdefaults sind inzwischen deklarativ umgesetzt.

### Allgemein

- [ ] Sprache/Region explizit deklarieren
- [ ] Zeitzone Europe/Berlin explizit deklarieren
- [x] automatische macOS Updates
- [x] automatische Security-/Critical-Updates
- [x] automatische Hintergrund-/ConfigData-Updates
- [x] App Store Updates automatisch
- [x] neue Dokumente standardmäßig lokal statt iCloud speichern
- [x] metrische Einheiten
- [x] Celsius
- [x] 24-Stunden-Zeit

### Tastatur

- [x] schnelle Key Repeat Rate
- [x] kurze Initial Key Repeat Delay
- [x] Press-and-Hold deaktiviert
- [x] Smart Quotes behalten
- [x] Smart Dashes behalten
- [x] Rechtschreibkorrektur behalten
- [x] automatische Großschreibung behalten

Editoren sollen Smart Quotes etc. selbst deaktivieren bzw. nicht verwenden.

### Trackpad

- [x] Tap to Click
- [x] Rechtsklick
- [x] Drei-Finger-Drag
- [x] Force-Click-Schwelle gesetzt
- [x] Tracking Speed angepasst
- [ ] Scroll-Verhalten bei Bedarf noch prüfen

### Finder

- [x] Dateiendungen immer anzeigen
- [x] Pfadleiste anzeigen
- [x] Statusleiste anzeigen
- [x] POSIX-Pfad im Titel
- [x] Suche standardmäßig im aktuellen Ordner
- [x] Warnung beim Ändern von Dateiendungen deaktiviert
- [x] versteckte Dateien im Finder standardmäßig nicht anzeigen
- [ ] keine `.DS_Store` auf Netzwerkshares
- [ ] keine `.DS_Store` auf USB-Laufwerken
- [x] externe Datenträger auf Desktop anzeigen
- [x] Server nicht auf Desktop anzeigen
- [x] Listenansicht als Standard

### Dock

- [x] Autohide
- [x] keine Autohide-Verzögerung
- [x] kurze Animation
- [x] keine Recent Apps
- [x] Minimize into Application
- [x] feste Dock-Größe
- [x] App-Indikatoren aktiv
- [x] ausgeblendete Apps transparent anzeigen
- [x] Dock unten
- [ ] gewünschte Apps deklarativ festlegen
- [ ] Downloads/Applications Stack deklarativ festlegen

### Desktop / Mission Control

- [x] Stage Manager aus
- [x] Klick auf Desktop blendet Fenster nicht aus
- [x] Spaces nicht automatisch umsortieren
- [x] Hot Corners deaktiviert
- [ ] Widgets-Verhalten prüfen
- [x] iPad/Sidecar weiterhin möglich
- [x] keine Multi-Monitor-Sonderkonfiguration notwendig

### Screenshots

- [x] Zielordner `~/Pictures/Screenshots`
- [x] PNG
- [x] Fensterschatten deaktiviert
- [x] Screenshot-Verzeichnis wird bereitgestellt

### Menüleiste

- [x] Bartender übernimmt Verwaltung
- [x] 24-Stunden-Uhr
- [x] Datum immer anzeigen
- [x] Wochentag anzeigen
- [x] Sekunden aus

### Sicherheit

- [x] Firewall aktiv
- [x] Stealth Mode aktiv
- [x] signierte Apps erlaubt
- [x] Touch ID für sudo
- [ ] FileVault Status prüfen
- [ ] FileVault / Recovery-Key-Strategie festlegen
- [x] Gatekeeper nicht deaktiviert
- [x] Ghostty Accessibility/TCC eingerichtet
- [ ] weitere TCC-Berechtigungen dokumentieren
- [ ] TCC-Schritte in Bootstrap integrieren

### Energie

#### Akku

- [x] Display Sleep: 5 Minuten
- [x] System Sleep: 10 Minuten
- [x] Power Nap aus
- [x] Wake on LAN aus
- [x] TCP Keepalive an
- [x] Low Power Mode nicht erzwungen

#### Netzbetrieb

- [x] Display Sleep: 15 Minuten
- [x] System Sleep: aus
- [x] Power Nap an
- [x] Wake on LAN an
- [x] TCP Keepalive an
- [x] Low Power Mode aus

Nicht verändert:

- Standby
- Hibernatemode
- Hibernatefile
- tty keep awake
- Disk Sleep

---

## Software

### Behalten / installieren

- [ ] Alfred
- [ ] AppCleaner
- [ ] Bloons TD 6+
- [ ] DockDoor
- [x] Ghostty vorhanden und konfiguriert
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

Behalten:

- [ ] Bartender
- [ ] CleanMyMac
- [ ] iBoysoft NTFS
- [ ] Mockuuups Studio
- [ ] Nitro PDF Pro
- [ ] PDF Squeezer

Setapp Login/Aktivierung wird wahrscheinlich teilweise manuell bleiben.

Zu prüfen:

- [ ] welche Setapp-Apps per CLI installierbar sind
- [ ] welche Apps zwingend GUI benötigen
- [ ] wie Setapp im Bootstrap installiert und gestartet wird

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

Global vorhanden:

- [ ] git explizit über Nix verwalten
- [ ] gh
- [ ] wget
- [ ] jq
- [x] bat
- [x] fd
- [x] ripgrep
- [x] eza
- [x] fzf
- [x] zoxide
- [x] nil
- [x] statix
- [x] nixfmt
- [x] just
- [x] Neovim Nightly
- [ ] direnv
- [ ] nix-direnv
- [ ] tree-sitter-cli
- [ ] Node LTS
- [ ] npm
- [ ] Bun latest
- [ ] Go latest
- [ ] Python latest

Projektabhängige Toolchains sollen in Projekt-Flakes liegen.

Nicht global installieren:

- cmake
- ninja
- pnpm
- LuaRocks
- PHP
- Composer
- sqlc
- Go-Tools
- air
- templ
- ginkgo
- mockgen

---

## Updates

### macOS

- [x] automatische Prüfung
- [x] automatische Downloads
- [x] automatische macOS Updates
- [x] Critical Updates
- [x] ConfigData Updates
- [x] App Store Auto-Updates

### mac-config

Ziel:

- [ ] tägliche Prüfung
- [ ] `git pull --ff-only`
- [ ] `nix flake update`
- [ ] vollständiger Build
- [ ] nur bei erfolgreichem Build aktivieren
- [ ] Logging
- [ ] Fehler sollen laufendes System nicht beschädigen
- [ ] Cleanup
- [ ] Rollback-Verhalten definieren

### Homebrew

- [ ] tägliches `brew update`
- [ ] tägliches `brew upgrade`
- [ ] Cask Updates
- [ ] Formula Updates

### Mac App Store

- [ ] MAS Updates automatisieren

### Toolchains

Node:

- [ ] aktuelle LTS-Linie automatisch verwalten
- [ ] tägliche Update-Prüfung

Bun:

- [ ] aktuelle stabile Version automatisch verwalten
- [ ] tägliche Update-Prüfung

Go:

- [ ] aktuelle stabile Version automatisch verwalten
- [ ] tägliche Update-Prüfung

Python:

- [ ] aktuelle stabile Version automatisch verwalten
- [ ] tägliche Update-Prüfung

Neovim:

- [x] Nightly über Flake/Input
- [ ] Update-Automation über täglichen Flake-Update-Workflow

---

## Homebrew

Nächster großer Arbeitsblock.

Ziel:

- [ ] `nix-homebrew` einbinden
- [ ] Homebrew automatisch installieren
- [ ] `/opt/homebrew` auf Apple Silicon sauber verwalten
- [ ] Formulae deklarativ verwalten
- [ ] Casks deklarativ verwalten
- [ ] MAS integrieren
- [ ] `mas` verwalten
- [ ] tägliche Updates
- [ ] Cleanup
- [ ] Ownership zwischen Nix und Brew klar trennen

Zu entscheiden:

- [ ] welche CLI-Tools über Nix laufen
- [ ] welche GUI-Apps über Homebrew Casks laufen
- [ ] welche Apps über MAS laufen
- [ ] welche Apps über Setapp laufen
- [ ] doppelte Installation derselben App verhindern

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

Zu prüfen:

- [ ] Apple Passwords als mögliche Secret-Quelle
- [ ] GitHub Secrets nur für CI/CD verwenden
- [ ] lokale Secrets unabhängig von GitHub verfügbar machen

---

## Mail

iCloud Mail wird über den Apple Account eingerichtet.

Zusätzliche Accounts:

- ausschließlich IMAP/SMTP
- [ ] Accounts deklarativ beschreiben
- [ ] Mail-Adressen nicht im Klartext speichern
- [ ] Daten aus sops laden
- [ ] Konfigurationsprofil erzeugen
- [ ] Mail.app Accounts provisionieren
- [ ] Profilinstallation automatisieren soweit macOS erlaubt
- [ ] Account-Aktivierung / Passwortbereitstellung testen
- [ ] prüfen, welche Einstellungen Apple Mail nach Profilinstallation übernimmt

---

## Alfred

- [ ] Installation automatisieren
- [ ] Autostart
- [ ] Preferences über iCloud oder deklarativ
- [ ] vorhandene Powerpack-Lizenz automatisiert aktivieren
- [ ] Lizenz aus bestehender Installation auslesen
- [ ] Lizenz verschlüsselt speichern
- [ ] unterstützte Aktivierungsmöglichkeiten prüfen
- [ ] Accessibility/TCC bleibt ggf. manuell
- [ ] Alfred-TCC-Schritte dokumentieren

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
- [ ] Homebrew initialisieren
- [ ] Setapp vorbereiten
- [ ] Ghostty TCC/Accessibility-Schritt ausgeben
- [ ] weitere manuelle TCC-Schritte ausgeben
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

### Home-Manager Altbestand

Bei bestehenden Systemen können alte Dateien Home-Manager-Aktivierungen blockieren.

Beispiel:

```text
~/.config/fish/config.fish
```

Vor Übernahme durch Home Manager:

- vorhandene Datei prüfen
- bei Bedarf sichern
- Altbestand entfernen
- Home Manager erneut aktivieren

Auf einer sauberen Neuinstallation sollte dieser Migrationsschritt nicht nötig sein.

---

## Manuelle / nicht vollständig deklarative Schritte

Aktuell bekannt:

- [x] Fish einmalig als Login-Shell setzen
- [x] Ghostty Accessibility für globalen Quick-Terminal-Shortcut
- [ ] Apple ID / iCloud Login
- [ ] App Store Login
- [ ] Setapp Login
- [ ] ggf. Setapp App-Aktivierungen
- [ ] ggf. Alfred Accessibility
- [ ] ggf. Alfred Lizenzaktivierung
- [ ] Mail-Passwort-/Profil-Aktivierung
- [ ] FileVault Recovery-Key-Handling
- [ ] weitere TCC-Berechtigungen

Diese Schritte sollen später im Bootstrap klar ausgegeben werden.

---

## Bekannte Warnungen

### options.json

Aktuell erscheint beim Build:

```text
Using 'builtins.derivation' to create a derivation named 'options.json'
that references the store path '...-source' without a proper context.
The resulting derivation will not have a correct store reference,
so this is unreliable and may stop working in the future.
```

Der Build läuft trotzdem erfolgreich durch.

Die Warnung stammt nicht aus eigener `builtins.derivation`-Logik in diesem Repo.

Bis eine konkrete Ursache in nixpkgs/Home Manager/nix-darwin identifiziert ist:

- keine lokalen Workarounds
- Warnung nicht unterdrücken
- bei zukünftigen Updates beobachten
- später gegen aktuelle Upstream-Versionen erneut prüfen

---

## Repo-Struktur

Aktuell / geplant:

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
        ├── defaults/
        │   ├── default.nix
        │   ├── global.nix
        │   ├── finder.nix
        │   ├── dock.nix
        │   ├── trackpad.nix
        │   ├── desktop.nix
        │   └── ui.nix
        ├── security.nix
        ├── updates.nix
        ├── power.nix
        ├── homebrew.nix
        └── mail.nix
```

---

## Nächste Schritte

### 1. Homebrew / Softwareverwaltung

- `nix-homebrew`
- Casks
- Formulae
- MAS
- Zuständigkeit pro App festlegen
- bestehende Softwareliste gegen aktuellen Mac prüfen

### 2. Developer Toolchains

- Node LTS
- npm
- Bun
- Go
- Python
- direnv / nix-direnv

### 3. Secrets

- sops-nix
- age
- Mail-Secrets
- Alfred-Lizenz

### 4. Mail

- IMAP/SMTP Accounts
- Profile
- Provisionierung

### 5. Automatische Updates

- mac-config
- Nix Flakes
- Homebrew
- MAS
- Toolchains
- Logging / Rollback

### 6. Finaler Bootstrap

Ziel:

Ein frisch installiertes macOS benötigt nach dem Setup Assistant nur noch einen klar definierten Bootstrap-Prozess und wenige unvermeidbare manuelle Apple-/TCC-Schritte.
