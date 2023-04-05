{ pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./networking.nix # generated at runtime by nixos-infect
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "22.11";

  boot.cleanTmpDir = true;
  networking.hostName = "box-727973";
  networking.firewall.allowPing = true;
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOq2y6ogY9D8fPo0TsabNBDKZB6jLE/j76cuI6b5+EMG varlamoved@yandex.ru" 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtlFL2K/npIc/17n/RN3S+gCu8bPfU/N1VB1flkJPT4 alexey.badenkov@gmail.com"
  ];


  programs.git.enable = true;
  programs.git.config = {
    init.defaultBranch = "main";
    url."https://github.com/".insteadOf = [ "gh:" "github:" ];
  };

  services.postgresql = {
    enable = true;
    #package = pkgs.postgresql_14;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host all all 127.0.0.1/32 trust
      host all all ::1/128 trust
    '';
    initialScript =  pkgs.writeText "backedn-initScript" ''
      CREATE ROLE nixcloud WITH LOGIN PASSWORD 'nixcloud' CREATEDB;
      CREATE DATABASE nixcloud;
      GRANT ALL PRIVILEGES ON DATABASE nixcloud TO nixcloud;
    '';
   
  };


}
