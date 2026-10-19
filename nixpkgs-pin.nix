# nixpkgs-pin.nix — picks a specific snapshot of nixpkgs
let
  rev = "f20cd90e28fe";     # a nixpkgs commit, e.g. the head of the nixos-26.05 branch
  sha256 = "1vv6crfchmhjk5j61zgajggc3cgkalak2rvng07g41cvlcf6ldhj";  # safety checksum, see step 3
in
import (builtins.fetchTarball {
  url = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
  inherit sha256;
})