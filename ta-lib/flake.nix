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
        ta-lib-nix = pkgs.stdenv.mkDerivation {
          pname = "ta-lib";
          version = "0.6.3";

          src = pkgs.fetchzip {
            url = "https://pip.vnpy.com/colletion/ta-lib-0.6.3-src.tar.gz";
            sha256 = "sha256-ZNaIBchqkAOX8z60YLgpS7dCRMw66ZI4q3dUoZbuiU4=";
          };

          nativeBuildInputs = with pkgs; [
            gcc
            binutils
            pkg-config
            automake
            autoconf
          ];

          buildInputs = [];

          installPhase = ''
            mkdir -p $out
            make install
          '';

          meta = {
            description = "ta-lib";
            liscense = pkgs.lib.licenses.mit;
            homepage = "https://ta-lib.org/";
          };
        };

        default = self.packages.${system}.ta-lib-nix;
      }
      );
    };
}
