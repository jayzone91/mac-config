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

- [x] Ghostty-Installation über Homebrew
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

Die wesentlichen Systemdefaults sind deklarativ umgesetzt.

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
- [x] Touch ID für `sudo`
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

## Softwareverwaltung

Zuständigkeiten:

```text
Nix / Home Manager
└── CLI- und Developer-Tools

Homebrew
└── GUI-Apps / Casks

Mac App Store
└── App-Store-Apps

Setapp
└── Setapp-Apps

Apple / macOS
└── Systemapps und Apple-ID-gebundene Komponenten
```

Doppelte Installation derselben Software über mehrere Paketmanager soll vermieden werden.

---

## Homebrew

### Basis

- [x] `nix-homebrew` eingebunden
- [x] bestehende Homebrew-Installation migriert
- [x] Apple-Silicon-Homebrew `/opt/homebrew`
- [x] kein Rosetta-/Intel-Homebrew
- [x] Homebrew über nix-darwin aktiviert
- [x] alte CLI-Formulae bereinigt
- [x] alte Drittanbieter-Taps entfernt
- [x] CLI-Tools aus Homebrew nach Nix verschoben
- [x] `cleanup = "uninstall"`
- [ ] tägliche Homebrew-Updates automatisieren

### Homebrew Casks

Deklarativ verwaltet:

- [x] AdGuard
- [x] Alfred
- [x] AppCleaner
- [x] DockDoor
- [x] Ghostty
- [x] GitHub Desktop
- [x] Google Chrome Dev
- [x] OpenVPN Connect
- [x] Setapp
- [x] Visual Studio Code Stable

Nicht mehr verwenden:

- [x] cmux entfernt
- [x] Flutter entfernt
- [x] VS Code Insiders entfernt

### Homebrew Formulae

Globale Developer-CLI-Tools sollen nicht über Homebrew verwaltet werden.

Bereinigt:

- [x] asdf
- [x] cmake
- [x] composer
- [x] eza
- [x] fd
- [x] fish
- [x] fzf
- [x] gh
- [x] git
- [x] go
- [x] ImageMagick
- [x] LuaRocks
- [x] Neovim
- [x] ninja
- [x] nvm
- [x] PHP
- [x] pnpm
- [x] Python
- [x] ripgrep
- [x] spaceship
- [x] sqlc
- [x] stow
- [x] tree-sitter-cli
- [x] wget
- [x] wimlib
- [x] zoxide
- [x] verbliebene Formula-Abhängigkeiten bereinigt

---

## Mac App Store

`mas` wird über Nix bereitgestellt.

Deklarativ verwaltet:

- [x] Bloons TD 6+
  - ID `1584423325`
- [x] Keynote
  - ID `361285480`
- [x] Numbers
  - ID `361304891`
- [x] Pages
  - ID `409201541`
- [x] Windows App
  - ID `1295203466`

Entfernt / nicht mehr installieren:

- [x] Ghostery Privacy Ad Blocker
- [x] Microsoft Excel
- [x] WhatsApp
- [x] Xcode Full App

Xcode Command Line Tools bleiben als Systemvoraussetzung erhalten.

---

## Setapp

Setapp selbst wird über Homebrew installiert.

Behalten:

- [x] Bartender
- [x] CleanMyMac
- [x] iBoysoft NTFS
- [x] Mockuuups Studio
- [x] Nitro PDF Pro
- [x] PDF Squeezer

CleanMyMac:

- behalten
- kein automatischer Start erforderlich

Setapp-Apps werden aktuell nicht pseudo-deklarativ automatisiert.

Zu prüfen:

- [ ] welche Setapp-Apps offiziell per CLI installierbar sind
- [ ] welche Apps zwingend die Setapp-GUI benötigen
- [ ] Setapp-Login im Bootstrap dokumentieren
- [ ] gewünschte Setapp-Apps im Bootstrap als Checkliste anzeigen
- [ ] prüfen, ob installierte Setapp-Apps automatisiert verifiziert werden können

Setapp Login/Aktivierung darf als manueller Bootstrap-Schritt bestehen bleiben.

---

## Entfernte / nicht mehr benötigte Software

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
- [x] Xcode Full App
- [x] pnpm
- [x] LuaRocks
- [x] sqlc
- [x] PHP
- [x] Composer
- [x] ImageMagick
- [x] cmake global
- [x] ninja global
- [x] Go Tooling global
- [x] air
- [x] templ
- [x] ginkgo
- [x] mockgen
- [x] cmux

---

## Developer Tools

### Bereits über Nix / Home Manager

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
- [x] mas

### Noch deklarativ fertigstellen

- [ ] git
- [ ] gh
- [ ] wget
- [ ] jq
- [ ] tree-sitter-cli
- [ ] direnv
- [ ] nix-direnv

### Toolchains

Node:

- [ ] aktuelle LTS-Linie bestimmen
- [ ] Node LTS über Nix verwalten
- [ ] npm über Node bereitstellen
- [ ] tägliche Update-Prüfung

Bun:

- [ ] aktuelle stabile Version über Nix verwalten
- [ ] tägliche Update-Prüfung

Go:

- [ ] aktuelle stabile Version über Nix verwalten
- [ ] tägliche Update-Prüfung

Python:

- [ ] aktuelle stabile Version über Nix verwalten
- [ ] tägliche Update-Prüfung

Projektabhängige Toolchains und Spezialabhängigkeiten sollen möglichst in Projekt-Flakes liegen.

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

## Alfred

### Installation

- [x] Alfred über Homebrew vorgesehen
- [x] Alfred installiert
- [x] vorhandene Powerpack-Lizenz vorhanden und aktuell aktiviert
- [ ] Autostart deklarativ konfigurieren
- [ ] Preferences-/Sync-Strategie festlegen

### Powerpack

Ziel:

Die vorhandene Alfred-Powerpack-Lizenz soll auf einem neuen Mac möglichst komfortabel wieder aktiviert werden können, ohne die Lizenz im Klartext im Repository abzulegen.

- [ ] vorhandenen Alfred-5-Powerpack-Lizenzblock sicher erfassen
- [ ] Lizenz als Secret behandeln
- [ ] Lizenz verschlüsselt über sops-nix speichern
- [ ] prüfen, ob Alfred eine offiziell unterstützte CLI-/URL-Aktivierung anbietet
- [ ] keine undokumentierten plist-/defaults-Hacks verwenden

Falls keine unterstützte automatische Aktivierung existiert:

```text
sops
  ↓
Alfred-Lizenz entschlüsseln
  ↓
temporär ins Clipboard
  ↓
Alfred Powerpack Preferences öffnen
  ↓
Lizenz einfügen
  ↓
Activate
```

Die entschlüsselte Lizenz soll:

- nicht ins Repository geschrieben werden
- nicht dauerhaft als Klartextdatei gespeichert werden
- möglichst nur temporär im Clipboard existieren

### Alfred Permissions

- [ ] Accessibility/TCC prüfen
- [ ] benötigte Alfred-Berechtigungen dokumentieren
- [ ] manuelle TCC-Schritte in Bootstrap aufnehmen

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
- [ ] Alfred-Powerpack-Lizenz
- [ ] zukünftige API Keys

Mail-Adressen sollen nicht im Klartext im Repository stehen.

Zu prüfen:

- [ ] Apple Passwords als mögliche Secret-Quelle
- [ ] GitHub Secrets nur für CI/CD verwenden
- [ ] lokale Secrets unabhängig von GitHub verfügbar machen
- [ ] Recovery-/Bootstrap-Strategie für age-Key

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

## Updates

### macOS

- [x] automatische Prüfung
- [x] automatische Downloads
- [x] automatische macOS Updates
- [x] Critical Updates
- [x] ConfigData Updates
- [x] App Store Auto-Updates

### mac-config / Nix

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
- [ ] Formula Updates, falls künftig Formulae benötigt werden
- [ ] Cleanup

Homebrew soll nicht bei jedem `darwin-rebuild` ungefragt Updates durchführen.

### Mac App Store

- [x] automatische App-Store-Updates über macOS aktiviert
- [ ] Verhalten mit deklarativen `masApps` auf neuem System testen

### Neovim

- [x] Nightly über Flake/Input
- [ ] Update über täglichen Flake-Update-Workflow automatisieren

### Toolchains

Node, Bun, Go und Python sollen über den täglichen Nix-/Flake-Update-Workflow aktuell gehalten werden.

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
- [ ] age-Key bereitstellen
- [ ] App Store Login voraussetzen/prüfen
- [ ] Homebrew initialisieren
- [ ] MAS-Apps installieren
- [ ] Setapp vorbereiten
- [ ] Setapp Login anfordern
- [ ] gewünschte Setapp-Apps prüfen
- [ ] Alfred-Powerpack-Aktivierung unterstützen
- [ ] Ghostty TCC/Accessibility-Schritt ausgeben
- [ ] Alfred TCC/Accessibility-Schritte ausgeben
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
- [ ] Alfred Accessibility
- [ ] Alfred Powerpack-Aktivierung, falls keine unterstützte Automation existiert
- [ ] Mail-Passwort-/Profil-Aktivierung
- [ ] FileVault Recovery-Key-Handling
- [ ] weitere TCC-Berechtigungen

Diese Schritte sollen später im Bootstrap klar und nacheinander ausgegeben werden.

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
│       ├── dev-tools.nix
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

### 1. Developer Toolchains

- git / gh / wget / jq / tree-sitter
- direnv / nix-direnv
- Node LTS
- npm
- Bun
- Go
- Python

### 2. Secrets

- sops-nix
- age
- Bootstrap-/Recovery-Strategie
- Mail-Secrets
- Alfred-Powerpack-Lizenz

### 3. Alfred

- Autostart
- Preferences
- Powerpack-Lizenz aus bestehender Installation übernehmen
- Aktivierungsworkflow
- TCC

### 4. Mail

- IMAP/SMTP Accounts
- Profile
- Provisionierung

### 5. Setapp Bootstrap

- Login
- App-Prüfung
- verbleibende manuelle Schritte

### 6. Automatische Updates

- mac-config
- Nix Flakes
- Homebrew
- Toolchains
- Logging
- Rollback

### 7. Restliche macOS-Details

- Sprache/Region
- Zeitzone
- `.DS_Store`
- Dock-Inhalt
- Widgets
- FileVault
- weitere TCC-Berechtigungen

### 8. Finaler Bootstrap

Ziel:

Ein frisch installiertes macOS benötigt nach dem Setup Assistant nur noch einen klar definierten Bootstrap-Prozess und wenige unvermeidbare Apple-, Login- und TCC-Schritte.