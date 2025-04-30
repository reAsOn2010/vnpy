{
  description = "ta-lib-python nix package";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    ta-lib-nix.url = "path:../ta-lib";
  };

  outputs = {self, nixpkgs, ta-lib-nix, ...}@inputs:
    let
      systems = ["x86_64-linux"];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
      let 
        pkgs = import nixpkgs { inherit system; };
        ta-lib = ta-lib-nix.packages.${system}.default;
      in 
      {
        ta-lib-python-nix = pkgs.python313Packages.buildPythonPackage {
          pname = "ta-lib-python";
          version = "0.6.3";
          src = pkgs.fetchFromGitHub {
            owner = "TA-Lib";
            repo = "ta-lib-python";
            rev = "TA_Lib-0.6.3";
            hash = "sha256-LtiUSG6t+mKfSIQ3WWac3qME2yI4VI+7R0MPq20GwOE=";
          };

          nativeBuildInputs = with pkgs; [
            pkg-config
            ta-lib

            python313Packages.setuptools
            python313Packages.pip
            python313Packages.wheel
            python313Packages.pipInstallHook
            python313Packages.numpy
          ];

          propagatedBuildInputs = with pkgs; [
            python313Packages.setuptools
            ta-lib
          ];

          meta = {
              description = "Python wrapper for TA-Lib";
              license = pkgs.lib.licenses.mit;
          };
        };

        default = self.packages.${system}.ta-lib-python-nix;
      }
      );
    };
}
