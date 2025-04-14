{ inputs, config, pkgs, hyprland, hy3, textfox, ... }:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.username      = "n3rdium";
  home.homeDirectory = "/home/n3rdium";
  home.stateVersion  = "24.05"; # Please don't touch

  home.packages = with pkgs; [
    # Essentials
    superfile
    xfce.thunar
    floorp
    zathura
    kdePackages.okular
    gcr

    # Astro
    gimp
    wine64Packages.wayland
    stellarium

    # Code
    trashy
    lua5_1
    nixd
    ruff
    rustup
    python3
    isort
    black
    stylua
    luarocks
    prettierd
    gcc
    tree-sitter
    ripgrep

    # Music
    musescore
    muse-sounds-manager
    lmms
    audacity
    pavucontrol
    youtube-music

    # Prod
    ffmpeg
    kdePackages.kdenlive
    blender
    obsidian

    # Rice Stuff
    cava
    wofi
    swww
    dunst
    kooha
    hyprshot
    fastfetch
    playerctl
    obs-studio
    hyprpicker

    # Fonts
    fira-code
    jetbrains-mono

    # Shell Stuff
    fzf
    fd
    imagemagick
    poppler
    atuin
    pure-prompt
    oh-my-zsh

    # Miscellaneous
    ollama
    discord
    ani-cli
    mangal
  ];


  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    plugins = [
        inputs.hy3.packages.x86_64-linux.hy3
    ];
    extraConfig = builtins.readFile (builtins.path {
        path = ./configs/hypr/hyprland.conf;
    });
  };

  programs.ags = {
    enable    = true;
    configDir = ./shell;

    # additional packages to add to gjs's runtime
    extraPackages = [
      inputs.ags.packages.${pkgs.system}.astal3
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.tray
    ];
  };

  programs.zoxide = {
    enable               = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable      = true;
    userName    = "n3rdium";
    userEmail   = "n3rdium@gmail.com";
    extraConfig = {
      credential.helper = "${
        pkgs.git.override { withLibsecret = true; }
      }/bin/git-credential-libsecret";
    };
  };

  gtk = {
    enable = true;

    theme = {
      name    = "Gruvbox-Dark";
      package = pkgs.gruvbox-gtk-theme;
    };

    iconTheme = {
      name    = "oomox-gruvbox-dark";
      package = pkgs.gruvbox-dark-icons-gtk;
    };
  };

  qt = {
    enable             = true;
    platformTheme.name = "gtk";
  };

  home.file = {
    ".config/kitty/".source        = ./configs/kitty;
    ".config/fastfetch/".source    = ./configs/fastfetch;
    ".config/cava/".source         = ./configs/cava;
    ".config/atuin/".source        = ./configs/atuin;
    ".config/nvim/lua".source      = ./configs/nvim/lua;
    ".config/nvim/init.lua".source = ./configs/nvim/init.lua;
    ".config/siril/".source        = ./configs/siril;
    ".zshrc".source                = ./configs/.zshrc;
    "wallpapers/".source           = ./theming/wallpapers;
    ".hyprshaders/".source         = ./configs/hypr/shaders;
    ".zenithassets/".source        = ./assets;
    ".zenithscripts/".source       = ./scripts;
  };

  home.sessionVariables = { EDITOR = "nvim"; };

  services.gnome-keyring.enable = true;

  programs.home-manager.enable = true;
}
