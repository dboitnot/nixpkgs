{
  lib,
  stdenv,
  fetchurl,
}:

stdenv.mkDerivation {
  name = "pkl";
  src = fetchurl {
    url = "https://github.com/apple/pkl/releases/download/0.25.3/pkl-linux-amd64";
    hash = "sha256-KU2WDCGzzjflmuJ9qMXJKIdjqE9uuYdyHCQVp8mRMps=";
    executable = true;
    downloadToTemp = true;
    postFetch = ''
      mkdir $out/bin
      mv $downloadedFile $out/bin/pkl
    '';
  };
}
