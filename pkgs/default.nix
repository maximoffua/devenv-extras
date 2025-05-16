{ pkgs, ... }:

{
  supabase-cli = pkgs.callPackage ./supabase-cli.nix {};
  sqls = pkgs.callPackage ./sqls.nix {};
  mqttx = pkgs.callPackage ./mqttx.nix {};
  coolify-cli = pkgs.callPackage ./coolify.nix {};
  protobuf-language-server = pkgs.callPackage ./protobuf-language-server.nix {};
}
