{ fetchFromGitHub, callPackage, makeRustPlatform, date, channel, rustChannelOf, sha256, ... }:
let
  rustSpecific = (rustChannelOf {
    inherit date channel sha256;
  }).rust;
in makeRustPlatform {
  cargo = rustSpecific;
  rustc = rustSpecific;
}
