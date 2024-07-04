{ pkgs, ... }:

{
  supabase-cli = pkgs.callPackage ./supabase-cli.nix {};
}
