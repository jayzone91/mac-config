{pkgs, ...}:

{
  home.packages = [
  pkgs.git
  pkgs.gh
  pkgs.wget
  pkgs.jq
  pkgs.tree-sitter
  pkgs.mas

  pkgs.go
  pkgs.python3
  ];
}
