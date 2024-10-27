#!/bin/sh

# Initialize variables
options=""  # For storing options
pkgs=""     # For storing positional arguments

# Parse command line arguments
while [ "$#" -gt 0 ]; do
  if echo "$1" | grep -q '^-'; then
    options="$options $1"  # Collect options/flags
  else
    pkgs="$pkgs $1"         # Collect positional arguments
  fi
  shift  # Move to the next argument
done


for pkg in $pkgs; do
  nix run github:Mic92/nix-update -- --flake $options packages.x86_64-linux."$pkg"
done
