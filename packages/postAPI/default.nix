{ yarn2nix-moretea, mainRepo, nodejs, python, libsass, pkgconfig, makeWrapper, ... }:

yarn2nix-moretea.mkYarnPackage rec {
  name = "dev-blog-post-api";
  src = "${mainRepo}/dev-blog-post-api";
  packageJSON = "${mainRepo}/dev-blog-post-api/package.json";
  yarnLock = ./yarn.lock;

  propagatedBuildInputs = [ makeWrapper ];

  buildPhase = ''
    yarn run build
  '';

  postInstall = ''
    makeWrapper ${nodejs}/bin/node $out/bin/post-api --add-flags $out/libexec/post-api/deps/post-api/dist/main.js
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

    "@angular/cli" = {
      prePatch = ''
        export NG_CLI_ANALYTICS=false
      '';
    };
  };

  yarnNix = ./yarn.nix;
}
