{
  description = "DevBlog - Despair Driven Development";

  edition = 201909;

  inputs.nixpkgs.url =
    "github:NixOS/nixpkgs/469f14ef0fade3ae4c07e4977638fdf3afc29e08";

  outputs = { self, nixpkgs }:
    let
      moz_overlay = import (builtins.fetchTarball {
        url =
          "https://github.com/mozilla/nixpkgs-mozilla/archive/efda5b357451dbb0431f983cca679ae3cd9b9829.tar.gz";
        sha256 = "11wqrg86g3qva67vnk81ynvqyfj0zxk83cbrf0p9hsvxiwxs8469";
      });

      pkgs = (import nixpkgs {
        system = "x86_64-linux";
        config = { allowUnfree = true; };
        overlays = [ moz_overlay ];
      });

      mainRepo = pkgs.fetchgit {
        url = "https://github.com/PierreStephaneVoltaire/devblog";
        rev = "a9421464445ae4f868b0b29bd62dce1017ab782c";
        sha256 = "1x5sv3x4gda9fy6wrki84h21fgx02ydvm7ps95vsxk205lsmm055";
        fetchSubmodules = true;
      };

      serveLandingScript = pkgs.writeScript "serveLanding" ''
        ${pkgs.python3}/bin/python -m http.server --directory ${self.packages.x86_64-linux.landingPage}
      '';
    in {
      packages.x86_64-linux.bucket =
        pkgs.callPackage ./packages/bucket { inherit mainRepo; };

      packages.x86_64-linux.landingPage =
        pkgs.callPackage ./packages/landingPage { inherit mainRepo; };

      packages.x86_64-linux.postAPI =
        pkgs.callPackage ./packages/postAPI { inherit mainRepo; };

      packages.x86_64-linux.navbar =
        pkgs.callPackage ./packages/navbar { inherit mainRepo; };

      apps.x86_64-linux.serveLanding = {
        type = "app";
        program = "${serveLandingScript}";
      };

      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = [];
      };
    };
}
