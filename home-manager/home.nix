{ config, pkgs, ... }:

{
  home.username      = "athan";
  home.homeDirectory = "/home/athan";
  home.stateVersion  = "23.11"; # Please read the comment before changing.

  ## working??
  nixpkgs.config = {
    allowUnfree          = true;
    allowUnfreePredicate = (pkg: true);
  };

  #test
  programs.autojump.enableZshIntegration = true;
  programs.zoxide.enableZshIntegration   = true;

  home.packages = with pkgs; [
    # apostrophe         # markdown editor
    # autojump           # folder jumper
    brave              # web browser
    massren            # rename multiple files using your text editor
    sops               # tool for managing secrets
    atuin              # shell history data
    briss              # cropping PDF file
    btop               # A monitor of resources
    cheat              # terminal helper
    audacity           # sound editor
    # conda              # for python usage
    crow-translate     # gui translate?
    czkawka            # duplicate finder
    # dutree             # - analyze file system usage written in Rust
    # electrum           # Debian? Lightweight Bitcoin wallet
    # geany
    # geany-with-vte
    ventoy-bin-full    # there are more versions
    glow               # Render markdown on the CLI, with pizzazz!
    # golden-cheetah      # debian?
    # golden-cheetah-bin  # debian?
    gpxsee             # GPS log file viewer and analyzer
    # jabref             # bibliography reference
    julia-bin          # probably the latest
    lf                 # terminal file manager
    libqalculate       # Desktop calculator
    losslesscut-bin    # cut/trim video files
    # marktext           # debian? markdown editor
    mindforger         # markdown notebook interesting
    # navi               # terminal helper and launcher
    vscodium-fhs       # ide 
    nb                 # terminal notebook manager
    neovim
    # nox                # - tools to work with nix old not working
    nvd                # nix package version diff tool
    obsidian           # note taking
    pssh               # Parallel ssh tools
    pyenv              # setup it ??
    qalculate-gtk      # Desktop calculator
    # qalculate-qt       # Desktop calculator
    # qgis               # newer version needs compiling
    qgis-ltr           # long term release needs compiling
    ranger             # terminal file manager
    rclone             # Command line program to sync files and directories to and from cloud storage
    rclone-browser     # Graphical Frontend to Rclone written in Qt
    # rstudio
    signal-cli         # signal messager
    signal-desktop     # signal messager
    skypeforlinux      # skype works
    # spyder             # python IDE
    telegram-desktop   # telegram messanger
    tg                 # telegram messanger
    # thiefmd            # ?? Markdown editor
    thunderbird-bin    # quite updated
    timeline           # Display and navigate information on a timeline.
    tldr               # terminal helper
    translate-shell    # trans cli translate
    # trilium-desktop    # markdown editor
    # ueberzugpp         # display images on terminal
    # viber              # - debian?
    quarto             # scientific and technical publishing system built on Pandoc
    vnote              # notebook gui 
    xdg-ninja          # checks your $HOME for unwanted files and directories.
    # youtube-dl         # is it blocked works ?
    yt-dlp             # to test
    # zettlr             # markdown editor
    zotero             # citation manager
    zoxide             # folder jumper #todo


    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
    "openssl-1.1.1w"
  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/athan/etc/profile.d/hm-session-vars.sh

  # home.sessionVariables = {
  #   EDITOR = "vim";
  # };

  # test for non-NixOs linux
  # targers.genericLinux.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
