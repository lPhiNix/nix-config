{...}: {
  # Aggregates the per-program home-manager modules.
  imports = [
    ./git.nix
    ./lazygit.nix
    ./java.nix
  ];
}
