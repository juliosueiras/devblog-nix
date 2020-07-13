{ yarn2nix-moretea, mainRepo, pkgconfig, libsass, python, ... }:

yarn2nix-moretea.mkYarnPackage rec {
  name = "navbar";
  src = "${mainRepo}/dev-blog-navbar";
  packageJSON = "${mainRepo}/dev-blog-navbar/package.json";
  yarnLock = "${mainRepo}/dev-blog-navbar/yarn.lock";
  yarnNix = ./yarn.nix;

  buildPhase = ''
    yarn run build
  '';

  installPhase = ''
    mkdir -p $out
    cp -a deps/dev-blog-${name}/dist/* $out/
  '';

  distPhase = "true";
  doDist = false;


  pkgConfig = {
    node-sass = {
      buildInputs = [ python libsass pkgconfig ];
      postInstall = ''
        LIBSASS_EXT=auto yarn --offline run build
      '';
    };
  };
}
