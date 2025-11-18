{
	description = "N3RDIUM's Lite Flake!";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }@inputs:
		let
			system = "x86_64-linux";
			lib = nixpkgs.lib;
            pkgs-unstable = inputs.hyprland.inputs.nixpkgs.legacyPkgs.${nixpkgs.stdenv.hostPlatform.system};

		in {
            hardware.graphics = {
                enable = true;
                package = pkgs-unstable.mesa;
            };

            nixosConfigurations.n3rdium = lib.nixosSystem {
                inherit system;
                modules = [
                    ./configuration.nix
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

