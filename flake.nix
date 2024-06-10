{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    nixpkgs,
    disko,
    lanzaboote,
    home-manager,
    ...
  }:
  {
    systems = ["x86_64-linux"];

    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs.inputs = inputs;
      modules = [
        disko.nixosModules.disko
        ./system/disko-config.nix
        {
          _module.args.disks = [ "/dev/nvme0n1" ];
        }
        lanzaboote.nixosModules.lanzaboote
        ./system/configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
        }
      ];
    };

    nixosConfigurations.iso = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
        ({ pkgs, ... }: {
          environment.systemPackages = [ pkgs.neovim pkgs.git pkgs.disko ];
          nix = {
            settings = {
              experimental-features = ["nix-command" "flakes"];
            };
          };
        })
      ];
    };

    diskoConfigurations.disko = import ./system/disko-config.nix;
  };
}
