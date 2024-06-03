{ lib
, stdenv
, fetchurl
,
}:

let
  src = fetchurl {
    url = "https://github.com/apple/pkl/releases/download/0.25.3/pkl-alpine-linux-amd64";
    hash = "sha256-+Qs/bIKyBuDZjfVoczFe19imLVXazoC/w3W8lIn9w+o=";
    executable = true;
  };
in
stdenv.mkDerivation {
  name = "pkl";
  inherit src;
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
    platforms = [ "x86_64-linux" ];
    mainProgram = "pkl";
  };
}
