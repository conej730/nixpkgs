{ lib
, stdenv
, fetchFromGitHub
, cmake
, ninja
, boost169
, zlib
, openssl
, websocketpp }:

stdenv.mkDerivation rec {
  pname = "cpprestsdk";
  version = "2.10.18";

  src = fetchFromGitHub {
    owner = "microsoft";
    repo = "cpprestsdk";
    rev = "v${version}";
    sha256 = "15k7636yr6y885i6bd9d1cwq45y490wfds48i3338i3ih427las4";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [
    boost169
    zlib
    openssl
    websocketpp
  ];

  patches = [
    ./gcc10_64_bit.patch
  ];

  doCheck = true;
  preCheck = ''
    export LD_LIBRARY_PATH=$PWD/Release/Binaries
  '';

  meta = with lib; {
    description = ''
      The C++ REST SDK is a Microsoft project for cloud-based
      client-server communication in native code using a modern
      asynchronous C++ API design. This project aims to help
      C++ developers connect to and interact with services.
    '';
    homepage = "https://github.com/microsoft/cpprestsdk";
    license = licenses.mit;
    platforms = with platforms; unix;
  };
}
