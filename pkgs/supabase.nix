{pkgs, ...}: {
  supabase-cli = pkgs.supabase-cli.override {
    buildGoModule = args:
      pkgs.buildGoModule (args
        // rec {
          version = "1.178.2";
          # version = "1.182.0";
          src = pkgs.supabase-cli.src.override {
            hash = "sha256-448YZRln7lxfv2df53C5fH0Hrow5lmz39bse6/lDnNo=";
            rev = "v${version}";
          };
          vendorHash = "sha256-Iay3cNqpaCgcsBTpAhds15CUhAfj0//+j3nhvWHqM8s=";
          postInstall = ''
            rm -f $out/bin/{codegen,docs,listdep}
            mv $out/bin/{cli,supabase}

            installShellCompletion --cmd supabase \
              --bash <($out/bin/supabase completion bash) \
              --fish <($out/bin/supabase completion fish) \
              --zsh <($out/bin/supabase completion zsh)
          '';
        });
  };
}
