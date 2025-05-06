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
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hy3 = {
      # Temporary: revert to github:outfoxxed/hy3 after outfoxxed/hy3#209 is merged
      url = "github:Daholli/hy3/fb2832c2d376332e612cd36a3273e793ecd6b62e";
      inputs.hyprland.follows = "hyprland";
    };
    zen-browser.url = "github:MarceColl/zen-browser-flake";
  };

  outputs = { nixpkgs, home-manager, hyprland, hy3, zen-browser, ... }@inputs:
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
