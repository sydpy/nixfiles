{ 
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
    systemd.enable = true;
  };

  wayland.windowManager.hyprland.settings = {
    env = [
      "XCURSOR_SIZE,24"
      "QT_QPA_PLATFORMTHEME,qt5ct"
    ];

    monitor = [
      "eDP-1, 2256x1504@60, 0x0, 1.333"
    ];

    input = {
        kb_layout = "us";
        kb_options = "compose:ralt";

        follow_mouse = true;

        touchpad = {
            natural_scroll = true;
            disable_while_typing = true;
            clickfinger_behavior = true;
            scroll_factor = 0.5;
        };
    };

    general = {
        gaps_in = 0;
        gaps_out = 0;
        border_size = 1;
        col.active_border = "rgba(33ccffee)";
        col.inactive_border = "rgba(595959aa)";

        layout = "master";
    };

    decoration = {
        blur = {
            enabled = false;
        };
    };

    animations = {
        enabled = false;
    };

    dwindle = {
        pseudotile = true;
        preserve_split = true;
    };

    master = {
        new_is_master = true;
    };

    gestures = {
        workspace_swipe = true;
    };

    misc = {
        force_default_wallpaper = 0;
    };


    # Binds
    "$mod" = "SUPER";

    bind = [
      "$mod+Shift, Q, killactive, "
      "$mod+Shift, E, exit, "
      "$mod, Space, togglefloating, "
      "$mod, D, exec, j4-dmenu-desktop --dmenu='bemenu -i -l 10'"
      "$mod+Shift, L, exec, swaylock"

      # Windows/Workspace management
      ## Swap windows
      "$mod+Shift, left, movewindow, l"
      "$mod+Shift, right, movewindow, r"
      "$mod+Shift, up, movewindow, u"
      "$mod+Shift, down, movewindow, d"

      ## Move focus
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, H, movefocus, l"
      "$mod, L, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"

      ## Workspace, window, tab switch with keyboard
      "$mod+Control, right, workspace, +1"
      "$mod+Control, left, workspace, -1"

      ## Fullscreen
      "$mod, F, fullscreen, 1"

      ## Switching
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"
      "$mod, S, togglespecialworkspace,"
      "$mod, Tab, cyclenext"
      "$mod, Tab, bringactivetotop,"
      "$mod, M, layoutmsg, swapwithmaster"
      
      ## Move window to workspace $mod + Alt + [0-9] 
      "$mod+Shift, 1, movetoworkspace, 1"
      "$mod+Shift, 2, movetoworkspace, 2"
      "$mod+Shift, 3, movetoworkspace, 3"
      "$mod+Shift, 4, movetoworkspace, 4"
      "$mod+Shift, 5, movetoworkspace, 5"
      "$mod+Shift, 6, movetoworkspace, 6"
      "$mod+Shift, 7, movetoworkspace, 7"
      "$mod+Shift, 8, movetoworkspace, 8"
      "$mod+Shift, 9, movetoworkspace, 9"
      "$mod+Shift, 0, movetoworkspace, 10"
      "$mod+Shift, S, movetoworkspace, special"
      
      ## Move workspace to monitor
      "$mod, bracketright, movecurrentworkspacetomonitor, +1"
      "$mod, bracketleft, movecurrentworkspacetomonitor, -1"
      
      # Applications
      "$mod, Return, exec, alacritty"
    ];

    binde = [
      ## Window split ratio
      "$mod, Minus, splitratio, -0.1"
      "$mod, Equal, splitratio, 0.1"
    ];

    bindm = [
      ## Move/resize windows
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
      "$mod, Z, movewindow"
    ];

    bindl = [
      ", XF86AudioMute, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
      "$mod+Shift, M, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 0%"
      "$mod+Shift, N, exec, playerctl next || playerctl position `bc <<< \"100 * $(playerctl metadata mpris:length) / 1000000 / 100\"`"
      ", XF86AudioNext, exec, playerctl next || playerctl position `bc <<< \"100 * $(playerctl metadata mpris:length) / 1000000 / 100\"`"
      "$mod+Shift, B, exec, playerctl previous"
      "$mod+Shift, P, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
    ];

    bindle = [
      ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", XF86MonBrightnessUp, exec, brightnessctl set '5%+'"
      ", XF86MonBrightnessDown, exec, brightnessctl set '5%-'"
    ];

    # Execs
    exec-once = [
      "waybar"
      "swayidle -w timeout 180 'swaylock -f -c 000000' \\
                  timeout 210 'hyprctl dispatch dpms off' \\
                  resume 'hyprctl dispatch dpms on' \\
                  timeout 600 'systemctl suspend' \\
                  before-sleep 'swaylock -f -c 000000'"
    ];

    # Rules
    windowrulev2 = [
      "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
      "float,class:^(pavucontrol)$"
      "float,title:^(Media viewer)$"
      "float,title:^(Volume Control)$"
      "float,title:^(Picture-in-Picture)$"
      "float,class:^(Viewnior)$"
      "float,title:^(DevTools)$"
      "float,class:^(file_progress)$"
      "float,class:^(confirm)$"
      "float,class:^(dialog)$"
      "float,class:^(download)$"
      "float,class:^(notification)$"
      "float,class:^(error)$"
      "float,class:^(confirmreset)$"
      "float,title:^(Open File)$:"
      "float,title:^(branchdialog)$"
      "float,title:^(Confirm to replace files)"
      "float,title:^(File Operation Progress)"
      "move 75 44%,title:^(Volume Control)$"
    ];
  };
}
