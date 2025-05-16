{ lib
, fetchFromGitHub
, buildGoModule
}:

buildGoModule (finalAttrs: {
  pname = "coolify-cli";
  version = "0.0.1";

  src = fetchFromGitHub {
    owner = "coollabsio";
    repo = finalAttrs.pname;
    rev = "v4.x";
    # rev = finalAttrs.version;
    hash = "sha256-aZ7OUgLULPTGWQJVa7ShoVYXOpp0FydbuzEuJqIN1bo=";
  };

  vendorHash = "sha256-HJebDj7dbmZEFHL/guJqRVPa9KDdQ7Q/PZp6IrtmGgk=";

  meta = with lib; {
    homepage = "https://github.com/coollabsio/coolify-cli";
    description = " CLI for Coolify self-hosted PaaS.";
    license = licenses.mit;
  };
})
