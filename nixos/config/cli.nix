{ inputs, config, pkgs, lib, ... }:
{
	programs.fish.enable = true;
	users.defaultUserShell = pkgs.fish;
}
