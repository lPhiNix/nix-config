{...}: {
  # Aggregates the per-program home-manager modules.
  imports = [
    ./git.nix
    ./java.nix
  ];
}
