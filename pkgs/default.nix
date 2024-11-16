{ pkgs, ... }:

{
  supabase-cli = pkgs.callPackage ./supabase-cli.nix {};
  sqls = pkgs.callPackage ./sqls.nix {};
}
