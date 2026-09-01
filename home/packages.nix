{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.caelestia-cli.packages.${pkgs.stdenv.hostPlatform.system}.with-shell

    wget
    neovim
    fastfetch
    fish

    btop
    starship
    opencode
    eza
    zoxide
    direnv
    trash-cli
    gnome-keyring
    gnumake
    bat
    ripgrep
    fd
    fzf
    jq
    curl
    figlet
  ];
}
