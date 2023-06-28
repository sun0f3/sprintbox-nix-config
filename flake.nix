{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.sb1 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = inputs // { system = system; };
      modules = [
        ./hardware-configuration.nix
        ./networking.nix # generated at runtime by nixos-infect
        ./configuration.nix
        ./systemd_puma.nix
        ./postgresql.nix
        ./redis.nix
        ./git.nix
        ./nginx.nix
        ./unit.nix
        ({ pkgs, ... } : {
          environment.systemPackages = with pkgs; [
            gnumake
            cron
            ruby_3_2
            nodejs
            #(ruby_3_2.withPackages (ps: with ps; [ bundler ]))
          ];
        })
        home-manager.nixosModules.home-manager
        ./user_buhduh.nix
      ];
    };
  };
}
