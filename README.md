# mac-config

Deklarative macOS-Konfiguration für meinen Mac auf Basis von Nix, nix-darwin und Home Manager.

Ziel des Projekts ist, einen frisch installierten Mac mit möglichst wenig manuellen Eingriffen reproduzierbar auf meinen gewünschten Systemzustand zu bringen.

## Ziele

Die Konfiguration verwaltet unter anderem:

- macOS-Systemeinstellungen
- CLI- und Developer-Tools
- Shell und Terminal
- Neovim
- GUI-Anwendungen
- Mac-App-Store-Anwendungen
- Secrets
- Mail-Accounts
- automatische Updates
- Bootstrap eines neuen Macs

Der aktuelle Entwicklungsstand und noch offene Aufgaben befinden sich in [`ROADMAP.md`](ROADMAP.md).

---

## Architektur

Die Zuständigkeiten sind bewusst getrennt.

```text
Nix / nix-darwin
├── macOS-Systemkonfiguration
├── Systempakete
├── Security
├── Power Management
├── Homebrew-Integration
└── Mac App Store

Home Manager
├── Benutzerpakete
├── Fish
├── Starship
├── Ghostty-Konfiguration
├── Neovim
├── CLI-Tools
└── Developer-Toolchains

Homebrew
└── native macOS GUI-Anwendungen / Casks

programs.mas
└── Mac-App-Store-Anwendungen

Setapp
└── Setapp-Anwendungen

sops-nix + age
└── Secrets
```

CLI-Tools und Entwicklungsumgebungen sollen grundsätzlich über Nix verwaltet werden.

Homebrew wird möglichst ausschließlich für native macOS-GUI-Anwendungen verwendet.

---

## Repository-Struktur

```text
mac-config/
├── flake.nix
├── flake.lock
├── Justfile
├── README.md
├── ROADMAP.md
│
├── bootstrap/
│   ├── README.md
│   └── bootstrap.sh
│
├── hosts/
│   └── MacbookPro/
│       └── default.nix
│
├── home/
│   ├── jay.nix
│   └── modules/
│       ├── shell.nix
│       ├── starship.nix
│       ├── cli.nix
│       ├── dev-tools.nix
│       ├── neovim.nix
│       └── ghostty.nix
│
├── modules/
│   └── darwin/
│       ├── defaults/
│       ├── security.nix
│       ├── updates.nix
│       ├── power.nix
│       ├── homebrew.nix
│       ├── mas.nix
│       ├── secrets.nix
│       └── mail.nix
│
└── secrets/
    └── secrets.yaml
```

Einige der geplanten Dateien werden erst mit den entsprechenden Funktionen angelegt.

---

## System

Aktuell ist folgende Maschine definiert:

```text
Host: MacbookPro
Architektur: Apple Silicon / aarch64-darwin
Benutzer: jay
Shell: Fish
Terminal: Ghostty
Editor: Neovim
```

---

## Paketverwaltung

### Nix

Nix ist die primäre Paketquelle für CLI- und Developer-Tools.

Unter anderem:

- Git
- GitHub CLI
- wget
- jq
- tree-sitter
- Fish
- Starship
- fzf
- zoxide
- eza
- bat
- fd
- ripgrep
- Neovim Nightly
- nil
- statix
- nixfmt
- just
- direnv
- nix-direnv

### Developer-Toolchains

Global über Nix:

- Node.js 24 LTS
- npm
- Bun
- Go
- Python

Projektabhängige Tools und spezielle Toolchains sollen möglichst in den jeweiligen Projekt-Flakes definiert werden.

### Homebrew

Homebrew wird für native macOS-GUI-Anwendungen verwendet.

Aktuell unter anderem:

- AdGuard
- Alfred
- AppCleaner
- DockDoor
- Ghostty
- GitHub Desktop
- Google Chrome Dev
- OpenVPN Connect
- Setapp
- Visual Studio Code

CLI-Tools sollen nicht parallel über Homebrew und Nix installiert werden.

### Mac App Store

Mac-App-Store-Anwendungen werden über das nix-darwin-Modul `programs.mas` verwaltet.

Aktuell:

- Bloons TD 6+
- Keynote
- Numbers
- Pages
- Windows App

App-Updates selbst werden durch die automatischen macOS-App-Store-Updates durchgeführt.

### Setapp

Setapp selbst wird über Homebrew installiert.

Die eigentlichen Setapp-Anwendungen werden aktuell weiterhin über Setapp verwaltet.

Dazu gehören unter anderem:

- Bartender
- CleanMyMac
- iBoysoft NTFS
- Mockuuups Studio
- Nitro PDF Pro
- PDF Squeezer

---

## macOS-Konfiguration

nix-darwin verwaltet bereits einen großen Teil der Systemeinstellungen.

Dazu gehören unter anderem:

- Finder
- Dock
- Trackpad
- Tastatur
- Screenshots
- Mission Control
- Menüleiste
- Firewall
- Touch ID für `sudo`
- Energieverwaltung
- automatische Systemupdates

Einige macOS-Funktionen wie TCC-/Accessibility-Berechtigungen können nicht vollständig deklarativ verwaltet werden und bleiben Bestandteil des Bootstrap-Prozesses.

---

## Justfile

Die häufigsten Befehle sind über `just` verfügbar.

### Konfiguration prüfen

```sh
just check
```

Führt einen Flake-Check durch, ohne die Konfiguration anzuwenden.

### System bauen

```sh
just build
```

Baut die nix-darwin-Konfiguration.

### System anwenden

```sh
just apply
```

Baut und aktiviert die aktuelle Konfiguration.

### Flake aktualisieren

```sh
just update
```

Aktualisiert die Flake-Inputs.

### Formatieren

```sh
just fmt
```

Formatiert die Nix-Konfiguration.

### Status

```sh
just status
```

Zeigt den aktuellen Repository-Status.

### Garbage Collection

```sh
just gc
```

Bereinigt nicht mehr benötigte Nix-Generationen bzw. Store-Einträge.

---

## Änderungen anwenden

Nach Änderungen an der Konfiguration grundsätzlich zuerst:

```sh
just check
```

Wenn der Check erfolgreich ist:

```sh
just apply
```

Anschließend die betroffene Funktion prüfen.

Änderungen sollten erst gepusht werden, wenn die neue Generation erfolgreich aktiviert und getestet wurde.

---

## Secrets

Secrets sollen mit `sops-nix` und `age` verwaltet werden.

Das Repository enthält ausschließlich verschlüsselte Secret-Dateien.

Geplant sind unter anderem:

- Mail-Adressen
- Mail-Benutzernamen
- Mail-Passwörter / App-Passwörter
- Alfred-Powerpack-Lizenz
- zukünftige API-Keys

Der private age-Key darf niemals im Repository gespeichert werden.

### Recovery

Der private age-Key wird lokal auf dem Mac gespeichert und zusätzlich als Recovery-Kopie in Apple Passwords / iCloud Keychain hinterlegt.

Damit ergibt sich:

```text
Git Repository
└── verschlüsselte Secrets

Mac
└── privater age-Key

Apple Passwords / iCloud Keychain
└── Recovery-Kopie des privaten age-Keys
```

Die vollständige Schritt-für-Schritt-Anleitung zum Erzeugen und Wiederherstellen des Keys wird in [`bootstrap/README.md`](bootstrap/README.md) dokumentiert.

---

## Bootstrap

Für eine komplette Neuinstallation siehe:

[`bootstrap/README.md`](bootstrap/README.md)

Langfristig soll `bootstrap/bootstrap.sh` möglichst viele der notwendigen Schritte automatisieren.

Der grundsätzliche Ablauf ist:

```text
macOS Setup Assistant
        ↓
Apple ID / iCloud
        ↓
Xcode Command Line Tools
        ↓
Determinate Nix
        ↓
mac-config klonen
        ↓
age-Key wiederherstellen
        ↓
nix-darwin aktivieren
        ↓
Fish als Login-Shell
        ↓
App Store / Setapp
        ↓
TCC-Berechtigungen
        ↓
Alfred Powerpack
        ↓
fertiges System
```

Einige Schritte wie Apple-ID-Anmeldung, TCC-Berechtigungen oder bestimmte Lizenzaktivierungen bleiben zwangsläufig interaktiv.

---

## Neovim

Die Neovim-Konfiguration wird separat gepflegt:

https://github.com/jayzone91/nvim

Neovim selbst sowie die für Nix benötigten Werkzeuge werden über diese macOS-Konfiguration bereitgestellt.

Die Neovim-Konfiguration enthält unter anderem Unterstützung für:

- Nix LSP über `nil`
- `statix`
- `nixfmt`

---

## Sicherheit

Die Konfiguration setzt unter anderem:

- macOS Firewall
- Stealth Mode
- Gatekeeper
- Touch ID für `sudo`
- verschlüsselte Secret-Verwaltung
- keine Klartext-Secrets im Repository

FileVault und die Recovery-Key-Strategie werden noch separat umgesetzt.

---

## Updates

macOS-System- und Security-Updates sind automatisch aktiviert.

Geplant ist zusätzlich ein automatisierter Update-Workflow für:

```text
mac-config
├── Git Pull
├── Flake Update
├── Build
├── Validierung
└── Aktivierung nur bei Erfolg

Homebrew
├── Update
├── Cask Upgrade
└── Cleanup
```

Ein fehlgeschlagenes Update darf die aktuell funktionierende Systemgeneration nicht beschädigen.

---

## Roadmap

Die vollständige Roadmap befindet sich in:

[`ROADMAP.md`](ROADMAP.md)

Sie enthält sowohl den aktuellen Stand als auch alle noch geplanten Arbeiten.

---

## Lizenz

Diese Konfiguration ist primär für mein persönliches macOS-Setup gedacht.

Teile davon können als Referenz für eigene nix-darwin-Konfigurationen verwendet werden. Hardware-, Benutzer-, Secret- und systemspezifische Einstellungen müssen entsprechend angepasst werden.
