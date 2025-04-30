{
  description = "ta-lib nix package";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = {self, nixpkgs, ...}@inputs:
    let
      systems = ["x86_64-linux"];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
      let 
        pkgs = import nixpkgs { inherit system; };
      in 
      {
        vnpy-ctp-nix = pkgs.python313Packages.buildPythonPackage {
          pname = "vnpy-ctp";
          version = "6.7.7.1";

          src = pkgs.fetchFromGitHub {
            owner = "vnpy";
            repo = "vnpy_ctp";
            rev = "main";
            sha256 = "sha256-OLUlyz1MAJc1SjjOEu6n3cHKJwCBN3cTuk1r1/F2rBA=";
          };

          nativeBuildInputs = with pkgs; [
            pkg-config
            stdenv.cc.cc
            gcc
            glibc
            glibc_multi

            python313Packages.setuptools
            python313Packages.pip
            python313Packages.wheel
          ];

          meta = {
            description = "vnpy-ctp";
            liscense = pkgs.lib.licenses.mit;
            homepage = "https://github.com/vnpy/vnpy_ctp";
          };
        };

        default = self.packages.${system}.vnpy-ctp-nix;
      }
      );
    };
}
