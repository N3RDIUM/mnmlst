{ inputs, config, pkgs, lib, ... }:
{
    environment.systemPackages = with pkgs; [
		git
		neovim
		kitty
    ];
}
