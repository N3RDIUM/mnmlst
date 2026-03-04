{ pkgs, ... }:
{
    home.packages = with pkgs; [
		cmatrix
		pipes-rs
        # gource
        mecab
    ];
}

