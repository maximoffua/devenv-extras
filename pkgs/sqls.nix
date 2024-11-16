{
  lib,
  go,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "sqls";
  version = "0.2.28";

  src = fetchFromGitHub {
    owner = "sqls-server";
    repo = pname;
    rev = "master";
    hash = "sha256-4orh8UOCJTs/7NDkDM8SQkghDgYdv6XvarZqqZZDAUo=";
  };
  vendorHash = "sha256-8jzecLaVUMlIJC2neb5XfvpBYIkkXnzvzq175ZBAnLo=";

  checkFlags = [
    "-run=^TestExtractTable"
  ];

  meta = {
    description = "SQL language server written in Go.";
    homepage = "https://github.com/sqls-server/sqls";
    license = lib.licenses.mit;
  };
}
