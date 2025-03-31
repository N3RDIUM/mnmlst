{
  description = "N3RDIUM's Flake!";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
        url = "github:aylur/astal";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
        url = "github:aylur/ags";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1?ref=0.48.0";
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = { nixpkgs, home-manager, hyprland, hy3, textfox, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;

    in {
        nixosConfigurations.n3rdium = lib.nixosSystem {
            inherit system;
            modules = [
              ./nixos/configuration.nix
              home-manager.nixosModules.home-manager
                {
                  home-manager.useGlobalPkgs = true;
                  home-manager.useUserPackages = true;
                  home-manager.backupFileExtension = "backup";
                  home-manager.users.n3rdium = import ./home.nix;
                  home-manager.extraSpecialArgs = { inherit inputs; };
                }
            ];
        };
    };
}
