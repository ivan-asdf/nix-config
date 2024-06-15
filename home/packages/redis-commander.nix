{ buildNpmPackage, fetchFromGitHub }:
buildNpmPackage rec {
  pname = "redis-commander";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "joeferner";
    repo = "redis-commander";
    rev = "v${version}";
    hash = "sha256-FZF8MiX1VzxpC7zuuuTGJZ5p7UguRODF+F2zfdaZG5Y=";
  };

  npmDepsHash = "sha256-MYPqy6YkX1GBIOPRn1jYWp/rPMHgK7wNp4Oswmw+a3Y=";
}
