{ lib
, buildGoModule
, fetchFromGitHub
, installShellFiles
, testers
, supabase-cli
, nix-update-script
}:

buildGoModule rec {
  pname = "supabase-cli";
  version = "2.6.3";

  src = fetchFromGitHub {
    owner = "supabase";
    repo = "cli";
    rev = "v${version}";
    hash = "sha256-/X8sef+/VDLjIPGVBwlkJLnKd150CglwV6vTjucxb58=";
  };

  vendorHash = "sha256-H4o38npYbF77NSO7EALjoH3EXdUCjIPDboWEhWE4hXo=";

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/supabase/cli/internal/utils.Version=${version}"
  ];

  doCheck = false; # tests are trying to connect to localhost

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    ls -l $out/bin
    rm -f $out/bin/{codegen,docs,listdep}
    mv $out/bin/{cli,supabase}

    installShellCompletion --cmd supabase \
      --bash <($out/bin/supabase completion bash) \
      --fish <($out/bin/supabase completion fish) \
      --zsh <($out/bin/supabase completion zsh)
  '';

  passthru = {
    tests.version = testers.testVersion {
      package = supabase-cli;
    };
    updateScript = nix-update-script { };
  };

  meta = with lib; {
    description = "CLI for interacting with supabase";
    homepage = "https://github.com/supabase/cli";
    license = licenses.mit;
    maintainers = with maintainers; [ gerschtli kashw2 ];
    mainProgram = "supabase";
  };
}


# {pkgs, ...}: {
#   supabase-cli = pkgs.supabase-cli.override {
#     buildGoModule = args:
#       pkgs.buildGoModule (args
#         // rec {
#           version = "1.178.2";
#           # version = "1.182.0";
#           src = pkgs.supabase-cli.src.override {
#             hash = "sha256-448YZRln7lxfv2df53C5fH0Hrow5lmz39bse6/lDnNo=";
#             rev = "v${version}";
#           };
#           vendorHash = "sha256-Iay3cNqpaCgcsBTpAhds15CUhAfj0//+j3nhvWHqM8s=";
#           postInstall = ''
#             rm -f $out/bin/{codegen,docs,listdep}
#             mv $out/bin/{cli,supabase}

#             installShellCompletion --cmd supabase \
#               --bash <($out/bin/supabase completion bash) \
#               --fish <($out/bin/supabase completion fish) \
#               --zsh <($out/bin/supabase completion zsh)
#           '';
#         });
#   };
# }
