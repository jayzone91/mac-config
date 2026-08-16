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

Node wird aktuell bewusst auf der LTS-Major-Linie 24 gehalten.

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

Mac-App-Store-Anwendungen werden über das native nix-darwin-Modul `programs.mas` verwaltet.

`mas` selbst wird über Nix bereitgestellt und nicht zusätzlich über Homebrew installiert.

Aktuell verwaltet:

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

Die Anmeldung bei Setapp und gegebenenfalls einzelne App-Aktivierungen bleiben Bestandteil des Bootstrap-Prozesses.

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

## Shell

Fish wird über Home Manager konfiguriert und als Login-Shell verwendet.

Die Shell-Umgebung umfasst unter anderem:

- Fish
- Starship
- fzf
- zoxide
- eza
- bat
- fd
- ripgrep

Da der macOS-Benutzer bereits vor nix-darwin existiert, muss Fish auf einem frisch installierten System einmalig als erlaubte Login-Shell registriert und anschließend für den Benutzer gesetzt werden.

Die vollständigen Schritte befinden sich in [`bootstrap/README.md`](bootstrap/README.md).

---

## Ghostty

Ghostty selbst wird als Homebrew-Cask installiert.

Die Konfiguration wird deklarativ über Home Manager verwaltet.

Unter anderem konfiguriert:

- Fish Shell Integration
- Catppuccin Light/Dark
- Nerd-Font-Unterstützung
- Tabs und Splits
- Clipboard-Verhalten
- Working-Directory-Vererbung
- Quick Terminal
- globaler Quick-Terminal-Shortcut `Ctrl+Shift+Space`
- linke Option-Taste als Alt

Für den globalen Shortcut ist einmalig eine macOS-Accessibility-/TCC-Berechtigung erforderlich.

---

## Neovim

Die Neovim-Konfiguration wird separat gepflegt:

https://github.com/jayzone91/nvim

Neovim Nightly selbst sowie die für Nix benötigten Werkzeuge werden über diese macOS-Konfiguration bereitgestellt.

Die Neovim-Konfiguration enthält unter anderem Unterstützung für:

- Nix LSP über `nil`
- `statix`
- `nixfmt`

Die lokale Neovim-Konfiguration befindet sich unter:

```text
~/Documents/GitHub/nvim
```

und wird über `~/.config/nvim` verwendet.

---

## Justfile

Die häufigsten Verwaltungsbefehle sind über `just` verfügbar.

Ohne Recipe:

```sh
just
```

zeigt die verfügbaren Befehle an.

### Konfiguration prüfen

```sh
just check
```

Führt aus:

```sh
nix flake check
```

Die Konfiguration wird geprüft, aber nicht aktiviert.

### System bauen

```sh
just build
```

Führt aus:

```sh
nix build .#darwinConfigurations.MacbookPro.system
```

Die vollständige Systemkonfiguration wird gebaut, aber noch nicht aktiviert.

### System aktivieren

```sh
just switch
```

Führt aus:

```sh
sudo darwin-rebuild switch --flake .#MacbookPro
```

Die aktuelle Konfiguration wird gebaut und aktiviert.

### Prüfen, bauen und aktivieren

```sh
just apply
```

führt nacheinander aus:

```text
check
↓
build
↓
switch
```

Dies ist der normale Weg, um Änderungen an der Systemkonfiguration anzuwenden.

### Flake aktualisieren

```sh
just update
```

Führt aus:

```sh
nix flake update
```

### Nix-Dateien formatieren

```sh
just fmt
```

Formatiert die Nix-Dateien mit `nixfmt`.

### Git-Status

```sh
just status
```

Führt aus:

```sh
git status --short
```

### Garbage Collection

```sh
just gc
```

Führt aus:

```sh
nix store gc
```

---

## Änderungen anwenden

Nach Änderungen an der Konfiguration grundsätzlich zuerst:

```sh
just check
```

Für einen vollständigen Test und die anschließende Aktivierung:

```sh
just apply
```

Anschließend die betroffene Funktion prüfen.

Änderungen sollten erst gepusht werden, wenn die neue Generation erfolgreich aktiviert und getestet wurde.

---

## Secrets

Secrets werden zukünftig mit `sops-nix` und `age` verwaltet.

Das Git-Repository soll ausschließlich verschlüsselte Secret-Dateien enthalten.

Geplant sind unter anderem:

- Mail-Adressen
- Mail-Benutzernamen
- Mail-Passwörter / App-Passwörter
- Alfred-Powerpack-Lizenz
- zukünftige API-Keys

### Sicherheitsmodell

```text
Git Repository
└── verschlüsselte secrets/secrets.yaml
        │
        │ verschlüsselt für öffentlichen age-Recipient
        ↓
Mac
└── privater age-Key
        │
        │ Recovery-Kopie
        ↓
Apple Passwords / iCloud Keychain
```

Der private age-Key darf niemals im Repository gespeichert werden.

### Lokaler age-Key

Der private Schlüssel wird auf dem Mac unter:

```text
~/Library/Application Support/sops/age/keys.txt
```

gespeichert.

Der öffentliche `age1...`-Recipient darf dagegen im Repository stehen und wird später in `.sops.yaml` verwendet.

### Recovery

Eine Recovery-Kopie des privaten age-Keys wird in Apple Passwords / iCloud Keychain gespeichert.

Auf einem neuen Mac ist damit nur ein einmaliger Recovery-Schritt erforderlich:

```text
Apple ID anmelden
        ↓
Apple Passwords synchronisieren
        ↓
age-Key wiederherstellen
        ↓
sops-nix kann Repository-Secrets entschlüsseln
```

Die vollständige Schritt-für-Schritt-Anleitung zum Erzeugen, Sichern und Wiederherstellen des age-Keys befindet sich in:

[`bootstrap/README.md`](bootstrap/README.md)

---

## Alfred

Alfred wird über Homebrew installiert.

Die vorhandene Powerpack-Lizenz soll später verschlüsselt über `sops-nix` verwaltet werden.

Geplanter Wiederherstellungsprozess:

```text
sops-nix
   ↓
Powerpack-Lizenz entschlüsseln
   ↓
temporär bereitstellen
   ↓
Alfred Powerpack aktivieren
```

Falls Alfred keine offiziell unterstützte automatisierte Aktivierung anbietet, wird die Lizenz nur temporär in die Zwischenablage gelegt und anschließend manuell in Alfred eingefügt.

Undokumentierte Änderungen an Alfred-Plists oder internen Aktivierungsdaten sollen vermieden werden.

Zusätzlich können einmalige Accessibility-/TCC-Berechtigungen erforderlich sein.

---

## Sicherheit

Die Konfiguration setzt unter anderem:

- macOS Firewall
- Stealth Mode
- Gatekeeper
- Touch ID für `sudo`
- zukünftig verschlüsselte Secret-Verwaltung
- keine Klartext-Secrets im Repository

FileVault und die Recovery-Key-Strategie werden noch separat umgesetzt.

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
App Store anmelden
        ↓
Setapp anmelden
        ↓
TCC-Berechtigungen
        ↓
Alfred Powerpack
        ↓
fertiges System
```

Einige Schritte bleiben zwangsläufig interaktiv:

- Apple-ID-/iCloud-Anmeldung
- App-Store-Anmeldung
- Setapp-Anmeldung
- Wiederherstellung des age-Keys
- TCC-/Accessibility-Berechtigungen
- gegebenenfalls Alfred-Powerpack-Aktivierung
- spätere Mail-Account-Aktivierung

---

## Updates

macOS-System-, Security- und App-Store-Updates sind automatisch aktiviert.

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

Node, Bun, Go, Python und weitere Nix-Pakete sollen über den Flake-Update-Workflow aktuell gehalten werden.

Bei Node soll zusätzlich berücksichtigt werden, wenn zukünftig eine neue LTS-Major-Linie verfügbar wird.

Ein fehlgeschlagenes Update darf die aktuell funktionierende Systemgeneration nicht beschädigen.

---

## Bekannte Build-Warnung

Aktuell kann beim Build folgende Warnung erscheinen:

```text
Using 'builtins.derivation' to create a derivation named 'options.json'
that references the store path '...-source' without a proper context.
The resulting derivation will not have a correct store reference,
so this is unreliable and may stop working in the future.
```

Der Build funktioniert trotzdem.

Die Warnung wird aktuell nicht durch einen lokalen Workaround unterdrückt und soll bei zukünftigen Updates von nixpkgs, Home Manager und nix-darwin erneut geprüft werden.

---

## Roadmap

Die vollständige Roadmap befindet sich in:

[`ROADMAP.md`](ROADMAP.md)

Sie enthält:

- bereits umgesetzte Funktionen
- aktuellen Projektstand
- noch offene Aufgaben
- geplante Bootstrap-Schritte
- bekannte Warnungen

Die README beschreibt dagegen primär Architektur und Benutzung des fertigen Systems.

---

## Lizenz

Diese Konfiguration ist primär für mein persönliches macOS-Setup gedacht.

Teile davon können als Referenz für eigene nix-darwin-Konfigurationen verwendet werden. Hardware-, Benutzer-, Secret- und systemspezifische Einstellungen müssen entsprechend angepasst werden.
