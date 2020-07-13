{ fetchFromGitHub, callPackage, pkg-config, openssl, mainRepo, ... }:

let
  mozillaRust = callPackage ./mozilla-rust.nix {
    date = "2020-01-15";
    channel = "nightly";
  };
in mozillaRust.buildRustPackage {
  name = "bucket";

  cargoPatches = [
    ./cargo.patch
  ];

  src = "${mainRepo}/dev-blog-bucket";

  buildInputs = [ pkg-config openssl.dev ];

  checkPhase = "true";

  cargoSha256 = null;
  verifyCargoDeps = true;
}
