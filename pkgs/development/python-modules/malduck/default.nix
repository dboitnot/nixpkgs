{ lib
, buildPythonPackage
, capstone
, click
, cryptography
, dnfile
, fetchFromGitHub
, pefile
, pycryptodomex
, pyelftools
, pythonOlder
, pytestCheckHook
, typing-extensions
, yara-python
}:

buildPythonPackage rec {
  pname = "malduck";
  version = "4.4.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "CERT-Polska";
    repo = pname;
    rev = "refs/tags/v${version}";
    hash = "sha256-CXHbU1AudvOJrG9MKYDQXeEtwrJODRPQtK43dQzZASE=";
  };

  propagatedBuildInputs = [
    capstone
    click
    cryptography
    dnfile
    pefile
    pycryptodomex
    pyelftools
    typing-extensions
    yara-python
  ];

  postPatch = ''
    substituteInPlace requirements.txt \
      --replace "pefile==2019.4.18" "pefile" \
      --replace "dnfile==0.11.0" "dnfile"
  '';

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "malduck"
  ];

  meta = with lib; {
    description = "Helper for malware analysis";
    mainProgram = "malduck";
    homepage = "https://github.com/CERT-Polska/malduck";
    changelog = "https://github.com/CERT-Polska/malduck/releases/tag/v${version}";
    license = with licenses; [ bsd3 ];
    maintainers = with maintainers; [ fab ];
  };
}
