{ pkgs, ... }:
{
    home.packages = with pkgs; [
		gcc
		ruff
		rustup
		python3
		lua5_1
		luarocks
		prettierd
		tree-sitter
        opencode
        # zed-editor
    ];
}
