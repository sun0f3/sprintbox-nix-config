{
  users.users.buhduh = {
    isNormalUser = true;
    group = "buhduh";
    extraGroups  = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOq2y6ogY9D8fPo0TsabNBDKZB6jLE/j76cuI6b5+EMG varlamoved@yandex.ru"
    ];

  };
  home-manager.users.buhduh = {pkgs, ...} : {

    home.stateVersion = "22.11";
    programs.home-manager.enable = true;
    home.packages = with pkgs; [
      gnumake
      fd
      ripgrep
      python311
      neofetch
    ];

    programs.git = {
      enable = true;
      userName = "BuhDuh";
      userEmail = "buhduh@buhduh.ru";
      aliases = {
        st = "status";
      };
    };
  };
}
