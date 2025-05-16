{ lib
, fetchFromGitHub
, buildGoModule
}:

buildGoModule (finalAttrs: {
  pname = "protobuf-language-server";
  version = "0.1.1";

  src = fetchFromGitHub {
    owner = "lasorda";
    repo = finalAttrs.pname;
    rev = "master";
    # rev = "v${finalAttrs.version}";
    hash = "sha256-xkqNGZsi8cKX+Tf//OrcmZ2tL3+1Fzv6bzGJgnqp/m0=";
  };

  vendorHash = "sha256-4nTpKBe7ekJsfQf+P6edT/9Vp2SBYbKz1ITawD3bhkI=";
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/lasorda/protobuf-language-server";
    description = "A language server implementation for Google Protocol Buffers.";
    mainProgram = finalAttrs.pname;
    license = licenses.asl20;
  };
})

