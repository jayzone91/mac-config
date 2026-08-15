{pkgs, ...}:

{
  home.packages = with pkgs; [
    # General development
    git
    gh
    wget
    jq
    tree-sitter

    # Toolchains
    go
    python3
    nodejs_24
    bun
  ];

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;

    nix-direnv.enable = true;
  };
}
