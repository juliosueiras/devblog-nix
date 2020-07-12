{ fetchFromGitHub, callPackage, makeRustPlatform, date, channel, ... }:
let
  mozillaOverlay = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    rev = "ab9b53ebbbf9fe803e0fd7718192e7f3ba2c7759";
    sha256 = "1v955b0km375i4ihyl3hgg3l0r3hflbwiyayn6jm0rcqlw9c6fay";
  };

  mozilla = callPackage "${mozillaOverlay.out}/package-set.nix" { };
  rustSpecific = (mozilla.rustChannelOf {
    date = date;
    channel = channel;
  }).rust;
in makeRustPlatform {
  cargo = rustSpecific;
  rustc = rustSpecific;
}
