# macOS Bootstrap

## Voraussetzungen

- Frisch installiertes macOS
- Benutzer `jay` wurde über den macOS Setup Assistant angelegt
- Repository wurde nach `~/Documents/GitHub/mac-config` geklont

## Bootstrap-Schritte

### Nix

Determinate Nix installieren.

### nix-darwin

Erste Systemkonfiguration anwenden:

```sh
nix run nix-darwin/master#darwin-rebuild -- switch --flake .#MacbookPro
```

### Fish als Login-Shell

Der macOS-Benutzer existiert bereits vor nix-darwin. Daher muss Fish beim
Bootstrap einmalig als erlaubte Login-Shell registriert und anschließend
für den Benutzer gesetzt werden.

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

## TODO

Diese manuellen Schritte später in `bootstrap.sh` automatisieren.
