{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };


  outputs = { self, nixpkgs, home-manager } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.sb1 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = inputs // { system = system; };
      modules = [
        ./configuration.nix
        {
          security.acme.acceptTerms = true;
          security.acme.defaults.email = "varlamoved@gmail.com";
          services.nginx.enable = true;
          services.nginx.virtualHosts."buhduh.ru" = {
            addSSL = true;
            enableACME = true;
            root = "/var/www/buhduh.ru";
          };
        }
        {
          users.users.buhduh = {
            isNormalUser = true;
            extraGroups  = [ "wheel" "networkmanager" ];
            openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOq2y6ogY9D8fPo0TsabNBDKZB6jLE/j76cuI6b5+EMG varlamoved@yandex.ru"
            ];

          };
        }
        home-manager.nixosModules.home-manager
        {
          #  home-manager.useGlobalPkgs = true;
          #  home-manager.useUserPackages = true;
          home-manager.users.buhduh = {pkgs, ...} : {

            home.stateVersion = "22.11";
            programs.home-manager.enable = true;
            home.packages = with pkgs; [
              gnumake
              fd
              ripgrep
              python
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
      ];
    };
  };
}
