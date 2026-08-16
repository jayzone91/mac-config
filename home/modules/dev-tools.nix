{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # General development
    git
    gh
    wget
    jq
    tree-sitter

    # Nix
    nixfmt
    statix
    nil

    # Toolchains
    go
    python3
    nodejs_24
    bun

    # Secrets
    age
    sops
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;

    nix-direnv.enable = true;
  };
}
