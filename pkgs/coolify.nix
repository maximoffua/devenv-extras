{ lib
, stdenv
, fetchFromGitHub
, buildGoModule
, installShellFiles
}:

buildGoModule (finalAttrs: {
  pname = "coolify-cli";
  version = "0.0.2-rc1";

  src = fetchFromGitHub {
    owner = "coollabsio";
    repo = finalAttrs.pname;
    rev = "v4.x";
    # rev = finalAttrs.version;
    hash = "sha256-aZ7OUgLULPTGWQJVa7ShoVYXOpp0FydbuzEuJqIN1bo=";
  };

  vendorHash = "sha256-HJebDj7dbmZEFHL/guJqRVPa9KDdQ7Q/PZp6IrtmGgk=";
  ldflags = [
    "-s"
    "-w"
    "-X=github.com/coollabsio/coolify-cli/cmd.CliVersion=${finalAttrs.version}"
  ];

  nativeBuildInputs = [ installShellFiles ];
  postInstall = lib.optionalString (stdenv.buildPlatform.canExecute stdenv.hostPlatform) ''
    mv -v $out/bin/coolify{-cli,}
    installShellCompletion --cmd coolify \
      --bash <($out/bin/coolify completion bash) \
      --zsh <($out/bin/coolify completion zsh) \
      --fish <($out/bin/coolify completion fish)
  '';

  meta = with lib; {
    homepage = "https://github.com/coollabsio/coolify-cli";
    description = "CLI for Coolify self-hosted PaaS.";
    mainProgram = "coolify";
    license = licenses.mit;
  };
})
