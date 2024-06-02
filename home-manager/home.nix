{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./git.nix
  ];

  home.username = "user";
  home.homeDirectory = "/home/user";
  home.stateVersion = "23.11";
  programs.home-manager.enable = true;

  xdg.enable = true;

  # Hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };
  xdg.configFile."hypr".source = ./hypr;

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
