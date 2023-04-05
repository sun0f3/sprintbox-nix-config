{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
  };


  outputs = { nixpkgs } @ inputs: let
    system = "x86_64-linux";
  in {
    nixosConfiguraions.sb1 = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs // { system = system; };
        modules = [
          ./configuration.nix
        ];
    };
  };
}    