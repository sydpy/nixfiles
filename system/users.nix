{
  pkgs, ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.greetd = {
    enable = true;
    settings = {
      terminal.vt = 1;
      initial_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --asterisks --user-menu --cmd ${pkgs.hyprland}/bin/Hyprland";
        user = "greeter";
      };
      default_session = {
        command = "initial_session";
      };
    };
  };

  programs.zsh.enable = true;
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    initialPassword = "changeme";
  };
  home-manager.users.user = import ../home-manager/home.nix;
}

