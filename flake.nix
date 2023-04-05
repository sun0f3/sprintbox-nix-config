{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
  };


  outputs = { self, nixpkgs } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfigurations.sb1 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { system = system; };
        modules = [
          ./configuration.nix
        ];
    };
  };
}    
