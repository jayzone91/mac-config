# macOS Bootstrap

Diese Anleitung beschreibt die vollständige Einrichtung eines frisch installierten Macs mit `mac-config`.

Ziel ist, nach dem macOS Setup Assistant mit möglichst wenigen manuellen Schritten den deklarativ definierten Systemzustand wiederherzustellen.

> [!IMPORTANT]
> Diese Anleitung ist gleichzeitig der Recovery-Pfad für einen neuen oder vollständig zurückgesetzten Mac.
>
> Insbesondere der private `age`-Key muss verfügbar sein, bevor verschlüsselte Secrets durch `sops-nix` verwendet werden können.

---

## Voraussetzungen

- frisch installiertes macOS
- Apple-Silicon-Mac
- Benutzer `jay` wurde über den macOS Setup Assistant angelegt
- Zugriff auf die verwendete Apple ID
- Zugriff auf Apple Passwords / iCloud Keychain
- Internetverbindung
- Zugriff auf das GitHub-Repository `jayzone91/mac-config`

Das Repository wird nach folgendem Pfad geklont:

```text
~/Documents/GitHub/mac-config
```

---

# Übersicht

Der vollständige Bootstrap läuft grundsätzlich in dieser Reihenfolge:

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
System prüfen
        ↓
App Store anmelden
        ↓
Setapp anmelden
        ↓
TCC / Accessibility
        ↓
Alfred Powerpack
        ↓
weitere Secrets / Mail
        ↓
fertiges System
```

Einige Schritte können aufgrund von macOS-Sicherheitsmechanismen nicht vollständig automatisiert werden.

---

# 1. macOS Setup Assistant

macOS normal installieren und den Setup Assistant durchlaufen.

Dabei den Benutzer:

```text
jay
```

anlegen.

Der Benutzer muss bereits existieren, bevor nix-darwin die Systemkonfiguration übernehmen kann.

---

# 2. Apple ID und iCloud

Mit der verwendeten Apple ID anmelden.

Insbesondere aktivieren bzw. synchronisieren:

- iCloud
- Apple Passwords / iCloud Keychain
- App Store

Apple Passwords wird später benötigt, um den privaten `age`-Recovery-Key wiederherzustellen.

Vor dem Fortfahren sicherstellen, dass die gespeicherten Passwörter auf dem neuen Mac verfügbar sind.

---

# 3. Xcode Command Line Tools

Die Xcode Command Line Tools installieren:

```sh
xcode-select --install
```

macOS zeigt anschließend den Installationsdialog an.

Nach Abschluss prüfen:

```sh
xcode-select -p
```

Erwartet wird normalerweise:

```text
/Library/Developer/CommandLineTools
```

Die vollständige Xcode-App aus dem Mac App Store wird für dieses Setup nicht benötigt.

---

# 4. Determinate Nix

Determinate Nix installieren.

Nach der Installation ein neues Terminal öffnen.

Anschließend prüfen:

```sh
nix --version
```

und:

```sh
nix flake --help
```

Beide Befehle müssen funktionieren.

---

# 5. Repository klonen

Verzeichnis anlegen:

```sh
mkdir -p "$HOME/Documents/GitHub"
cd "$HOME/Documents/GitHub"
```

Repository klonen:

```sh
git clone https://github.com/jayzone91/mac-config.git
```

Danach:

```sh
cd mac-config
```

Prüfen:

```sh
git status
```

Der erwartete Repository-Pfad ist:

```text
~/Documents/GitHub/mac-config
```

---

# 6. Secrets mit SOPS und age

Secrets werden mit `sops-nix`, `sops` und `age` verwaltet.

Das Git-Repository enthält ausschließlich verschlüsselte Secret-Daten.

Der private `age`-Key darf niemals im Git-Repository gespeichert werden.

## Verwendete Speicherorte

### Privater age-Key

```text
~/Library/Application Support/sops/age/keys.txt
```

Vollständiger Pfad für den Benutzer `jay`:

```text
/Users/jay/Library/Application Support/sops/age/keys.txt
```

Diese Datei enthält den privaten Schlüssel und darf nicht versioniert werden.

### SOPS-Konfiguration

Im Root des `mac-config`-Repositories:

```text
~/Documents/GitHub/mac-config/.sops.yaml
```

Die Datei enthält unter anderem den öffentlichen `age1...`-Recipient.

Sie darf und soll versioniert werden.

### Verschlüsselte Secrets

```text
~/Documents/GitHub/mac-config/secrets/secrets.yaml
```

Diese Datei enthält ausschließlich verschlüsselte Secret-Werte und wird versioniert.

### Recovery-Kopie

Der private age-Key wird zusätzlich in:

```text
Apple Passwords / iCloud Keychain
```

gesichert.

Der Eintrag trägt exakt den Namen:

```text
mac-config age recovery key
```

## Sicherheitsmodell

```text
Git Repository
│
├── .sops.yaml
│   └── öffentlicher age1... Recipient
│
└── secrets/
    └── secrets.yaml
        └── verschlüsselte Secrets

Mac
└── ~/Library/Application Support/sops/age/keys.txt
    └── privater AGE-SECRET-KEY-...

Apple Passwords / iCloud Keychain
└── mac-config age recovery key
    └── Recovery-Kopie des privaten Keys
```

---

# 7. age und SOPS bei der Ersteinrichtung bereitstellen

Wenn die Systemkonfiguration noch nicht aktiviert wurde, stehen `age` und `sops` möglicherweise noch nicht dauerhaft zur Verfügung.

Für die Ersteinrichtung können beide temporär über Nix gestartet werden:

```sh
nix shell nixpkgs#age nixpkgs#sops
```

Danach prüfen:

```sh
command -v age-keygen
command -v sops
```

Nach der späteren Aktivierung der `mac-config` werden beide Werkzeuge dauerhaft über Nix bereitgestellt.

---

# 8. age-Key bei der Ersteinrichtung erzeugen

Dieser Abschnitt wird **nur einmal** benötigt, wenn für `mac-config` noch kein age-Key existiert.

Existiert bereits ein Key und wird lediglich ein neuer Mac eingerichtet, keinen neuen Key erzeugen.

Stattdessen direkt mit:

[age-Key auf einem neuen Mac wiederherstellen](#10-age-key-auf-einem-neuen-mac-wiederherstellen)

fortfahren.

## Verzeichnis anlegen

```sh
mkdir -p "$HOME/Library/Application Support/sops/age"
chmod 700 "$HOME/Library/Application Support/sops/age"
```

## Key erzeugen

```sh
age-keygen -o "$HOME/Library/Application Support/sops/age/keys.txt"
```

Anschließend:

```sh
chmod 600 "$HOME/Library/Application Support/sops/age/keys.txt"
```

## Öffentlichen Recipient anzeigen

```sh
age-keygen -y "$HOME/Library/Application Support/sops/age/keys.txt"
```

Die Ausgabe sieht ungefähr so aus:

```text
age1xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

Dieser `age1...`-Wert ist der **öffentliche Recipient**.

Er darf im Git-Repository gespeichert werden.

> [!WARNING]
> Der private Key beginnt dagegen mit:
>
> ```text
> AGE-SECRET-KEY-
> ```
>
> Dieser Wert darf niemals ins Repository gelangen.

---

# 9. Privaten age-Key in Apple Passwords sichern

Unmittelbar nach der erstmaligen Erzeugung des Keys eine Recovery-Kopie anlegen.

In Apple Passwords einen neuen Eintrag mit exakt diesem Namen anlegen:

```text
mac-config age recovery key
```

Als Passwort bzw. Secret den privaten age-Key aus:

```text
~/Library/Application Support/sops/age/keys.txt
```

hinterlegen.

Der private Schlüssel beginnt mit:

```text
AGE-SECRET-KEY-
```

Der private Key darf insbesondere **nicht** gespeichert werden in:

- Git
- GitHub
- `.sops.yaml`
- `README.md`
- `ROADMAP.md`
- Nix-Dateien
- Shell-Skripten
- unverschlüsselten Dateien innerhalb des Repositories

Nach der Speicherung prüfen, dass der Eintrag:

```text
mac-config age recovery key
```

über Apple Passwords / iCloud Keychain verfügbar ist.

Erst danach sollten echte Secrets mit diesem Key verschlüsselt werden.

---

# 10. age-Key auf einem neuen Mac wiederherstellen

Auf einem neuen Mac wird **kein neuer age-Key erzeugt**.

Stattdessen wird der bestehende private Key aus Apple Passwords wiederhergestellt.

## Verzeichnis anlegen

```sh
mkdir -p "$HOME/Library/Application Support/sops/age"
chmod 700 "$HOME/Library/Application Support/sops/age"
```

## Key aus Apple Passwords holen

In Apple Passwords nach folgendem Eintrag suchen:

```text
mac-config age recovery key
```

Dort ist die Recovery-Kopie des privaten age-Keys hinterlegt.

Den gespeicherten privaten Key kopieren.

Anschließend folgende Datei anlegen:

```text
~/Library/Application Support/sops/age/keys.txt
```

Beispielsweise:

```sh
nano "$HOME/Library/Application Support/sops/age/keys.txt"
```

Den privaten Key einfügen und speichern.

Danach:

```sh
chmod 600 "$HOME/Library/Application Support/sops/age/keys.txt"
```

> [!WARNING]
> Auf einem neuen Mac niemals einfach `age-keygen` ausführen, wenn bereits verschlüsselte Secrets existieren.
>
> Ein neuer Key kann die vorhandenen Secrets nicht entschlüsseln.

---

# 11. age-Key prüfen

Den öffentlichen Recipient aus dem privaten Key ableiten:

```sh
age-keygen -y "$HOME/Library/Application Support/sops/age/keys.txt"
```

Ausgabe:

```text
age1...
```

Dieser Wert muss mit dem Recipient in:

```text
~/Documents/GitHub/mac-config/.sops.yaml
```

übereinstimmen.

Dadurch wird sichergestellt, dass der richtige private Key vorhanden ist.

---

# 12. `.sops.yaml` einrichten

Die SOPS-Konfiguration befindet sich im Root des Repositories:

```text
~/Documents/GitHub/mac-config/.sops.yaml
```

Bei der erstmaligen Einrichtung:

```sh
cd "$HOME/Documents/GitHub/mac-config"
nano .sops.yaml
```

Inhalt:

```yaml
creation_rules:
  - path_regex: secrets/.*\.yaml$
    age: age1DEIN_OEFFENTLICHER_RECIPIENT
```

`age1DEIN_OEFFENTLICHER_RECIPIENT` durch den öffentlichen Recipient aus:

```sh
age-keygen -y "$HOME/Library/Application Support/sops/age/keys.txt"
```

ersetzen.

Die `.sops.yaml` enthält **keinen privaten Schlüssel** und wird deshalb normal mit Git versioniert.

Prüfen:

```sh
cat .sops.yaml
```

---

# 13. Erstes verschlüsseltes Secret anlegen

Secrets befinden sich unter:

```text
~/Documents/GitHub/mac-config/secrets/
```

Verzeichnis anlegen:

```sh
cd "$HOME/Documents/GitHub/mac-config"
mkdir -p secrets
```

Neue verschlüsselte Datei mit SOPS öffnen:

```sh
sops secrets/secrets.yaml
```

Für einen ersten Funktionstest:

```yaml
test: funktioniert
```

eintragen und den Editor speichern und schließen.

SOPS verschlüsselt den Wert beim Speichern.

---

# 14. Verschlüsselung prüfen

Die gespeicherte Datei anzeigen:

```sh
cat secrets/secrets.yaml
```

Der Wert:

```text
funktioniert
```

darf dort nicht im Klartext erscheinen.

Stattdessen sollte der Secret-Wert ungefähr folgendermaßen aussehen:

```text
ENC[AES256_GCM,...]
```

Zusätzlich enthält die Datei einen `sops:`-Metadatenblock.

---

# 15. Secret manuell entschlüsseln

Test:

```sh
sops --decrypt secrets/secrets.yaml
```

Erwartet:

```yaml
test: funktioniert
```

Dabei keine entschlüsselten Secrets dauerhaft in Dateien schreiben.

Insbesondere vermeiden:

```sh
sops --decrypt secrets/secrets.yaml > secrets-plain.yaml
```

Eine solche Klartextdatei könnte versehentlich im Dateisystem oder Repository verbleiben.

---

# 16. Fehler: SOPS findet keine Creation Rules

Bei:

```sh
sops secrets/secrets.yaml
```

kann folgende Meldung erscheinen:

```text
config file not found, or has no creation rules,
and no keys provided through command line options
```

Dann zuerst sicherstellen, dass man sich im Repository befindet:

```sh
cd "$HOME/Documents/GitHub/mac-config"
pwd
```

Erwartet:

```text
/Users/jay/Documents/GitHub/mac-config
```

Prüfen, ob `.sops.yaml` existiert:

```sh
ls -la .sops.yaml
```

Anschließend:

```sh
cat .sops.yaml
```

Sie muss eine passende `creation_rules`-Regel enthalten:

```yaml
creation_rules:
  - path_regex: secrets/.*\.yaml$
    age: age1...
```

Explizit mit der Konfiguration testen:

```sh
sops --config .sops.yaml secrets/secrets.yaml
```

Wenn dieser Befehl funktioniert, aber:

```sh
sops secrets/secrets.yaml
```

nicht, liegt ein Problem mit der automatischen Erkennung der SOPS-Konfiguration vor.

---

# 17. Erste nix-darwin-Konfiguration

Im Repository:

```sh
cd "$HOME/Documents/GitHub/mac-config"
```

Die erste Systemkonfiguration anwenden:

```sh
nix run nix-darwin/master#darwin-rebuild -- switch --flake .#MacbookPro
```

Dieser erste Aufruf ist notwendig, weil `darwin-rebuild` auf einem frisch installierten System noch nicht über die Systemkonfiguration bereitgestellt wird.

Nach erfolgreicher Aktivierung prüfen:

```sh
command -v darwin-rebuild
```

---

# 18. Fish als Login-Shell

Der macOS-Benutzer existiert bereits vor nix-darwin.

Daher muss Fish beim Bootstrap einmalig als erlaubte Login-Shell registriert und anschließend für den Benutzer gesetzt werden.

```sh
FISH_PATH="/run/current-system/sw/bin/fish"

grep -qxF "$FISH_PATH" /etc/shells ||
  echo "$FISH_PATH" | sudo tee -a /etc/shells

chsh -s "$FISH_PATH"
```

Prüfen:

```sh
dscl . -read /Users/jay UserShell
```

Erwartet:

```text
UserShell: /run/current-system/sw/bin/fish
```

Anschließend Terminal bzw. Ghostty vollständig schließen und neu öffnen.

Danach:

```sh
echo $SHELL
```

Erwartet:

```text
/run/current-system/sw/bin/fish
```

---

# 19. Home-Manager-Altbestand

Dieser Schritt betrifft hauptsächlich bestehende Systeme oder Migrationen.

Auf einem frisch installierten Mac sollte er normalerweise nicht notwendig sein.

Home Manager überschreibt vorhandene Benutzerdateien nicht ungefragt.

Beispielsweise kann folgende Datei eine Aktivierung blockieren:

```text
~/.config/fish/config.fish
```

Falls Home Manager meldet:

```text
Existing file '...' would be clobbered
```

die betroffene Datei zunächst prüfen.

Beispiel:

```sh
cat ~/.config/fish/config.fish
```

Falls es sich um Altbestand handelt:

```sh
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.old
```

Danach die Konfiguration erneut anwenden.

Nicht blind vorhandene Konfigurationsdateien löschen.

---

# 20. Systemkonfiguration prüfen

Nach dem ersten erfolgreichen Bootstrap:

```sh
cd "$HOME/Documents/GitHub/mac-config"
```

Flake prüfen:

```sh
just check
```

System bauen:

```sh
just build
```

Bei erfolgreichem Build kann zukünftig der normale Workflow verwendet werden:

```sh
just apply
```

`just apply` führt nacheinander aus:

```text
check
↓
build
↓
switch
```

---

# 21. Developer-Tools prüfen

Die wichtigsten Werkzeuge prüfen:

```sh
git --version
gh --version
wget --version
jq --version
tree-sitter --version

node --version
npm --version
bun --version
go version
python3 --version

direnv --version
mas --version
age --version
sops --version
```

Anschließend die Pfade prüfen:

```sh
type -a git
type -a gh
type -a node
type -a npm
type -a bun
type -a go
type -a python3
type -a mas
type -a age
type -a sops
```

Die Nix-Versionen sollen im PATH vor eventuell vorhandenen macOS-Systemversionen liegen.

Typischerweise:

```text
/etc/profiles/per-user/jay/bin/...
```

bzw. für Systempakete:

```text
/run/current-system/sw/bin/...
```

---

# 22. sops-nix Runtime prüfen

Nach Aktivierung der `sops-nix`-Konfiguration sollte das Test-Secret zur Laufzeit entschlüsselt verfügbar sein.

Prüfen:

```sh
sudo cat /run/secrets/test
```

Erwartet:

```text
funktioniert
```

Damit ist die vollständige Kette getestet:

```text
Apple Passwords
        │
        │ Recovery
        ↓
lokaler age Private Key
        │
        ↓
secrets/secrets.yaml
        │
        │ SOPS
        ↓
verschlüsselt in Git
        │
        │ sops-nix bei Aktivierung
        ↓
/run/secrets/test
```

Nach erfolgreichem Funktionstest kann das Dummy-Secret wieder entfernt und durch echte Secrets ersetzt werden.

---

# 23. Mac App Store

Mit der verwendeten Apple ID im Mac App Store anmelden.

Die deklarativ verwalteten Apps werden über `programs.mas` installiert.

Aktuell gehören dazu:

- Bloons TD 6+
- Keynote
- Numbers
- Pages
- Windows App

Prüfen:

```sh
mas list
```

`mas` selbst wird über Nix bereitgestellt.

Es soll keine zusätzliche Homebrew-Installation von `mas` existieren.

---

# 24. Homebrew-Anwendungen prüfen

Homebrew wird für native macOS-GUI-Anwendungen verwendet.

Prüfen:

```sh
brew list --cask
```

Die deklarativ verwalteten Anwendungen umfassen unter anderem:

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

Fehlende Casks sollten über die nix-darwin-Konfiguration und nicht dauerhaft manuell verwaltet werden.

---

# 25. Setapp

Setapp starten und anmelden.

Anschließend die benötigten Anwendungen über Setapp installieren bzw. aktivieren.

Aktuell vorgesehen:

- Bartender
- CleanMyMac
- iBoysoft NTFS
- Mockuuups Studio
- Nitro PDF Pro
- PDF Squeezer

Die vollständige Automatisierbarkeit dieses Schrittes wird noch geprüft.

---

# 26. Ghostty

Ghostty starten.

Die Konfiguration wird durch Home Manager bereitgestellt.

Prüfen:

- Fish startet korrekt
- Starship wird angezeigt
- Nerd-Font-Symbole funktionieren
- Tabs funktionieren
- Splits funktionieren
- Working Directory wird übernommen
- `Ctrl+Shift+Space` öffnet das Quick Terminal

## Accessibility

Für den globalen Quick-Terminal-Shortcut benötigt Ghostty eine Accessibility-Berechtigung.

Unter:

```text
System Settings
→ Privacy & Security
→ Accessibility
```

Ghostty erlauben.

Danach Ghostty gegebenenfalls vollständig neu starten.

---

# 27. Touch ID für sudo

Touch ID für `sudo` wird durch nix-darwin konfiguriert.

Test:

```sh
sudo -k
sudo true
```

Die Authentifizierung sollte über Touch ID möglich sein.

Das Benutzerpasswort bleibt als Fallback verfügbar.

---

# 28. Alfred

Alfred wird über Homebrew installiert.

Alfred starten und die benötigten macOS-Berechtigungen erteilen.

Insbesondere prüfen:

```text
System Settings
→ Privacy & Security
→ Accessibility
```

Weitere von Alfred benötigte Berechtigungen abhängig von den verwendeten Funktionen ebenfalls erlauben.

## Powerpack

Die Alfred-Powerpack-Lizenz soll verschlüsselt über `sops-nix` bereitgestellt werden.

Falls keine offiziell unterstützte automatische Aktivierung verfügbar ist, soll der Bootstrap die entschlüsselte Lizenz nur temporär bereitstellen.

Geplanter Ablauf:

```text
sops-nix
 ↓
Powerpack-Lizenz entschlüsseln
 ↓
temporär ins Clipboard
 ↓
Alfred Preferences öffnen
 ↓
Powerpack aktivieren
```

Keine undokumentierten Änderungen an Alfred-internen Plists oder Aktivierungsdaten verwenden.

---

# 29. Mail

iCloud Mail wird über die Apple-ID-/iCloud-Anmeldung bereitgestellt.

Zusätzliche IMAP-/SMTP-Accounts sollen über verschlüsselte Secrets und Konfigurationsprofile eingerichtet werden.

Geplant:

```text
sops-nix
    ↓
Mail-Secrets
    ↓
Konfigurationsprofil
    ↓
Mail.app
```

Bis dieser Teil umgesetzt ist, bleibt die Einrichtung zusätzlicher Mail-Accounts ein manueller Schritt.

---

# 30. FileVault

Der aktuelle FileVault-Status kann geprüft werden mit:

```sh
fdesetup status
```

Die endgültige FileVault- und Recovery-Key-Strategie ist noch nicht Bestandteil des automatisierten Bootstraps.

Bis diese festgelegt ist, FileVault nicht automatisiert verändern.

---

# 31. Abschlussprüfung

Nach dem vollständigen Bootstrap mindestens prüfen:

## Shell

```sh
echo $SHELL
```

Erwartet:

```text
/run/current-system/sw/bin/fish
```

## Systemgeneration

```sh
darwin-rebuild --list-generations
```

## Nix

```sh
nix --version
```

## Developer-Tools

```sh
git --version
node --version
bun --version
go version
python3 --version
```

## Secrets

```sh
age --version
sops --version
```

Falls das Test-Secret noch existiert:

```sh
sudo cat /run/secrets/test
```

## Mac App Store

```sh
mas list
```

## Homebrew

```sh
brew list --cask
```

## Gesamtkonfiguration

```sh
cd "$HOME/Documents/GitHub/mac-config"
just check
```

Der Check muss ohne Fehler durchlaufen.

---

# 32. Normaler Workflow nach dem Bootstrap

Nach erfolgreicher Einrichtung werden Änderungen im Repository vorgenommen.

Konfiguration prüfen:

```sh
just check
```

Komplett bauen und aktivieren:

```sh
just apply
```

Flake aktualisieren:

```sh
just update
```

Nix-Dateien formatieren:

```sh
just fmt
```

Status anzeigen:

```sh
just status
```

Nix Store bereinigen:

```sh
just gc
```

---

# Manuelle Schritte

Folgende Schritte können aktuell nicht vollständig deklarativ oder zuverlässig automatisiert werden:

- Apple-ID-/iCloud-Anmeldung
- Apple-Passwords-Synchronisierung
- age-Key-Recovery
- App-Store-Anmeldung
- Setapp-Anmeldung
- Setapp-App-Aktivierungen
- Ghostty Accessibility
- Alfred Accessibility und weitere TCC-Berechtigungen
- gegebenenfalls Alfred-Powerpack-Aktivierung
- zusätzliche Mail-Account-Aktivierung
- FileVault-Recovery-Key-Handling

Diese Liste soll mit fortschreitender Automatisierung kleiner werden.

---

# Troubleshooting

## `darwin-rebuild: command not found`

Auf einem frisch installierten System den ersten Build mit:

```sh
nix run nix-darwin/master#darwin-rebuild -- switch --flake .#MacbookPro
```

ausführen.

Danach sollte `darwin-rebuild` über das Systemprofil verfügbar sein.

---

## Fish ist nach dem Switch weiterhin nicht die Login-Shell

Prüfen:

```sh
grep fish /etc/shells
```

und:

```sh
dscl . -read /Users/jay UserShell
```

Falls notwendig:

```sh
FISH_PATH="/run/current-system/sw/bin/fish"

grep -qxF "$FISH_PATH" /etc/shells ||
  echo "$FISH_PATH" | sudo tee -a /etc/shells

chsh -s "$FISH_PATH"
```

Danach das Terminal vollständig neu starten.

---

## Home Manager meldet `would be clobbered`

Die angegebene Datei existiert bereits und würde von Home Manager verwaltet werden.

Datei zuerst prüfen und gegebenenfalls sichern.

Beispiel:

```sh
mv ~/.config/fish/config.fish ~/.config/fish/config.fish.old
```

Anschließend:

```sh
just apply
```

Nicht pauschal alle vorhandenen Konfigurationsdateien löschen.

---

## SOPS meldet `config file not found`

Fehler:

```text
config file not found, or has no creation rules,
and no keys provided through command line options
```

Zuerst ins Repository wechseln:

```sh
cd "$HOME/Documents/GitHub/mac-config"
```

Prüfen:

```sh
pwd
ls -la .sops.yaml
cat .sops.yaml
```

Die Datei muss beispielsweise enthalten:

```yaml
creation_rules:
  - path_regex: secrets/.*\.yaml$
    age: age1...
```

Expliziter Test:

```sh
sops --config .sops.yaml secrets/secrets.yaml
```

---

## SOPS kann Secrets nicht entschlüsseln

Prüfen, ob der private Key vorhanden ist:

```sh
ls -l "$HOME/Library/Application Support/sops/age/keys.txt"
```

Berechtigungen korrigieren:

```sh
chmod 600 "$HOME/Library/Application Support/sops/age/keys.txt"
```

Öffentlichen Recipient bestimmen:

```sh
age-keygen -y "$HOME/Library/Application Support/sops/age/keys.txt"
```

Dieser muss mit dem in:

```text
~/Documents/GitHub/mac-config/.sops.yaml
```

hinterlegten Recipient übereinstimmen.

Danach erneut:

```sh
sops --decrypt secrets/secrets.yaml
```

testen.

Falls der private Key verloren gegangen ist, die Recovery-Kopie aus Apple Passwords verwenden:

```text
mac-config age recovery key
```

---

## Mac-App-Store-Apps werden nicht installiert

Prüfen:

```sh
mas list
```

und sicherstellen, dass der Benutzer im Mac App Store angemeldet ist.

`mas` soll aus dem Nix-Systemprofil kommen:

```sh
type -a mas
```

Erwartet wird ein Pfad unter:

```text
/run/current-system/sw/bin/
```

und keine separate Homebrew-Installation.

---

# TODO

Der manuelle Bootstrap soll schrittweise durch:

```text
bootstrap/bootstrap.sh
```

automatisiert werden.

Das Skript soll langfristig:

- Voraussetzungen prüfen
- Xcode Command Line Tools vorbereiten
- Determinate Nix installieren
- Repository klonen
- prüfen, ob der age-Key vorhanden ist
- age-Key-Recovery aus Apple Passwords begleiten
- SOPS-Entschlüsselung prüfen
- nix-darwin initialisieren
- Fish als Login-Shell konfigurieren
- App-Store-Status prüfen
- Setapp vorbereiten
- TCC-Schritte anzeigen
- Alfred-Aktivierung unterstützen
- Abschlussprüfungen durchführen

Sicherheitskritische oder von macOS bewusst interaktiv gehaltene Schritte sollen dabei nicht mit fragwürdigen Workarounds umgangen werden.
