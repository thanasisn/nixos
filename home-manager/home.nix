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
    # autojump           # folder jumper
    brave              # web browser
    briss              # cropping PDF file
    btop               # A monitor of resources
    cheat              # terminal helper
    conda              # for python usage
    crow-translate     # gui translate?
    czkawka            # duplicate finder
    mindforger         # markdown notebook intersting
    marktext           # markdown editor
    # dutree             # - analyze file system usage written in Rust
    # electrum           # work? Lightweight Bitcoin wallet
    # geany
    # geany-with-vte
    glow               # Render markdown on the CLI, with pizzazz!
    # golden-cheetah      # work?
    # golden-cheetah-bin  # work?
    gpxsee             # GPS log file viewer and analyzer
    julia-bin          # probably the latest
    lf                 # terminal file manager
    losslesscut-bin    # cut/trim video files
    # navi               # terminal helper and launcher
    neovim
    # nox                # - tools to work with nix old not working
    nvd                # nix package version diff tool
    obsidian           # note taking
    pssh               # Parallel ssh tools
    # qgis               # newer version needs compiling
    qgis-ltr           # long term release needs compiling
    rclone             # Command line program to sync files and directories to and from cloud storage
    rclone-browser     # Graphical Frontend to Rclone written in Qt
    # rstudio
    skypeforlinux      # skype works
    # spyder             # python IDE
    thunderbird-bin    # quite updated
    timeline           # Display and navigate information on a timeline.
    tldr               # terminal helper
    translate-shell    # trans cli translate
    # ueberzugpp         # display images on terminal
    viber              # - ?
    xdg-ninja          # checks your $HOME for unwanted files and directories.
    # youtube-dl         # is it blocked works ?
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
