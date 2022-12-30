{
  description = "Convert between Kindle clippings and org mode";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ self, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      perSystem = { pkgs, lib, config, system, inputs', ... }:
        let
          orgparse = pkgs.python3Packages.buildPythonPackage rec {
            pname = "orgparse";
            version = "0.3.1";
            src = pkgs.python3Packages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-hg5vu5pnt0K6p5LmD4zBhSLpeJwGXSaCHAIoXV/BBK8=";
            };
            buildInputs = with pkgs.python3Packages; [
              setuptools-scm
              pytest
            ];
          };
          kindleToOrg = pkgs.python3Packages.buildPythonPackage {
            name = "kindleToOrg";
            propagatedBuildInputs = [ orgparse ];
            src = ./.;
          };
          shell = pkgs.mkShell {
            name = "KindleToOrg-shell";
            nativeBuildInputs = [
              pkgs.python3
              pkgs.pyright
              kindleToOrg
            ];
          };
        in
        {
          packages.default = kindleToOrg;
          devShells.default = shell;
        };
    };
}


