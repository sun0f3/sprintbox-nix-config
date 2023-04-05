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
            users.users.buhduh = {
              isNormalUser = true;
              home = "/home/buhduh";
	      extraGroups  = [ "wheel" "networkmanager" ];
              openssh.authorizedKeys.keys = [];
            };
          }
          home-manager.nixosModules.home-manager
          #{
          #  home-manager.useGlobalPkgs = true;
          #  home-manager.useUserPackages = true;
          #  home-manager.users.buhduh = {
          #    programs.git = {
          #      enable = true;
          #      attributes = {
          #        name = "buhduh";
          #        email= "buhduh@buhduh.ru";
          #      };
          #      aliases = {
          #        st = "status";
          #      };
          #    };
          #  };
          #}
        ];
    };
  };
}    
