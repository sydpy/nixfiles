{
  config, pkgs,
  ...
}: {
  imports = [
    ./git.nix
    ./hyprland.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  xdg.enable = true;

  # Waybar
  xdg.configFile."waybar".source = ./waybar;

  # Neovim
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
  xdg.configFile."nvim".source = ./nvim;

  # Alacritty
  xdg.configFile."alacritty".source = ./alacritty;
}
