{ fetchFromGitHub, callPackage, pkg-config, openssl, mainRepo, ... }:

let
  mozillaRust = callPackage ./mozilla-rust.nix {
    date = "2020-01-15";
    channel = "nightly";
  };
in mozillaRust.buildRustPackage {
  name = "dev-blog-bucket";

  cargoPatches = [
    ./cargo.patch
  ];

  src = "${mainRepo}/dev-blog-bucket";

  buildInputs = [ pkg-config openssl.dev ];

  checkPhase = "";

  cargoSha256 = "15x5z6n6g42fp79q9lfgy77apkhndwfvbm6fh39yzbkvd94kx7s5";
  verifyCargoDeps = true;
}
