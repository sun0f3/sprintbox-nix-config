{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "22.11";

  nixpkgs.config.allowUnfree = true;

  boot.cleanTmpDir = true;
  networking.hostName = "box-727973";
  networking.firewall = {
    enable = true;
    allowPing = true;
    allowedTCPPorts = [ 22 80 443 3000];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };
  services.openssh.enable = true;
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOq2y6ogY9D8fPo0TsabNBDKZB6jLE/j76cuI6b5+EMG varlamoved@yandex.ru" 
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJtlFL2K/npIc/17n/RN3S+gCu8bPfU/N1VB1flkJPT4 alexey.badenkov@gmail.com"
  ];
}
