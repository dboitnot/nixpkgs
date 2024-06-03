{ lib
, stdenv
, fetchurl
}:

let
  hashes = {
    linux-x86_64 = "sha256-+Qs/bIKyBuDZjfVoczFe19imLVXazoC/w3W8lIn9w+o=";
    macos-x86_64 = "";
    macos-aarch64 = "";
  };
  version = "0.25.3";
  os = if stdenv.isDarwin then "macos" else "linux";
  arch = if stdenv.isAarch64 then "aarch64" else "x86_64";
  apple_arch = if stdenv.isAarch64 then "aarch64" else "amd64";
  platform = "${os}-${arch}";
  src = fetchurl {
    url = "https://github.com/apple/pkl/releases/download/${version}/pkl-alpine-linux-${apple_arch}";
    hash = hashes.${platform};
    executable = true;
  };
in
stdenv.mkDerivation {
  pname = "pkl";
  inherit src version;
  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/lib
    cp ${src} $out/bin/pkl
    runHook postInstall
  '';

  meta = with lib; {
    description = "A configuration as code language with rich validation and tooling published by Apple.";
    homepage = "https://pkl-lang.org/";
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    license = licenses.asl20;
    maintainers = with maintainers; [ dboitnot ];
    platforms = [ "x86_64-linux" "aarch64-macos" "x86_64-macos" ];
    mainProgram = "pkl";
  };
}
