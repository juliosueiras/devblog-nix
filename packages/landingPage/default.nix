{ yarn2nix-moretea, mainRepo, ... }:

yarn2nix-moretea.mkYarnPackage rec {
  name = "landing-page";
  src = "${mainRepo}/dev-blog";
  packageJSON = "${mainRepo}/dev-blog/package.json";
  yarnLock = "${mainRepo}/dev-blog/yarn.lock";
  yarnNix = ./yarn.nix;

  buildPhase = ''
    rm deps/landingpage/node_modules
    mkdir deps/landingpage/node_modules
    ln -s $node_modules/.bin deps/landingpage/node_modules/.bin
    substituteInPlace deps/landingpage/angular.json --replace node_modules ../../node_modules
    yarn run build
  '';

  installPhase = ''
    mkdir -p $out
    cp -a deps/landingpage/dist/landingPage/* $out/
  '';

  distPhase = "true";
  doDist = false;
}
