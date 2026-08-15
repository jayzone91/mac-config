set shell := ["fish", "-c"]

host := "MacbookPro"

default:
    @just --list

check:
    nix flake check

build:
    nix build .#darwinConfigurations.{{host}}.system

switch:
    sudo darwin-rebuild switch --flake .#{{host}}

apply: check build switch

update:
    nix flake update

fmt:
    nixfmt **/*.nix

status:
    git status --short

gc:
    nix store gc
