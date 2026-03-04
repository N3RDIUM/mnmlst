{ pkgs, ... }:
{
    home.packages = with pkgs; [
		gcr
		sl
		fzf
		atuin
		starship
		zoxide
		fd
		dust
		ripgrep
		ripgrep-all
		tokei
		mprocs
    ];

	programs.git = {
		enable = true;
        package = pkgs.gitFull;
        settings = {
            user = {
                name = "n3rdium";
                email = "n3rdium@gmail.com";
            };
			credential.helper = "libsecret";
        };
    };

	home.sessionVariables = { EDITOR = "nvim"; };
}

