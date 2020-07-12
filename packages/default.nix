{ pkgs ? import <nixpkgs> {} }:

let
  mainRepo = pkgs.fetchgit {
    url = "https://github.com/PierreStephaneVoltaire/devblog";
    rev = "a9421464445ae4f868b0b29bd62dce1017ab782c";
    sha256 = "1x5sv3x4gda9fy6wrki84h21fgx02ydvm7ps95vsxk205lsmm055";
    fetchSubmodules = true;
  };
in {
  bucket = pkgs.callPackage ./bucket {
    inherit mainRepo;
  };
}
