{ inputs, lib, ... }:

let
  mailAccounts = import ./mail-accounts.nix;

  mailFields = [
    "address"
    "username"
    "password"
    "imap_host"
    "imap_port"
    "smtp_host"
    "smtp_port"
  ];

  mailSecrets = lib.listToAttrs (
    lib.concatMap (
      account:
      map (field: {
        name = "mail/${account}/${field}";
        value = {
          owner = "jay";
        };
      }) mailFields
    ) mailAccounts
  );
in
{
  imports = [
    inputs.sops-nix.darwinModules.sops
  ];

  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;

    age.keyFile = "/Users/jay/Library/Application Support/sops/age/keys.txt";

    secrets = {
      "alfred/powerpack_license" = {
        owner = "jay";
      };
    }
    // mailSecrets;
  };
}
