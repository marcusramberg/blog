{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  env.GREET = "devenv";

  # https://devenv.sh/packages/
  packages = [ pkgs.hugo ];

  # https://devenv.sh/scripts/
  scripts.new.exec = ''
    POST=content/post/$(date +%Y-%m-%d)-$1.md
    hugo new $POST
    nvim $POST
    git add $POST
    git commit -am"Add $POST"
  '';
  enterShell = ''
    hugo
  '';

  # https://devenv.sh/languages/
  # languages.nix.enable = true;

  # https://devenv.sh/pre-commit-hooks/
  # pre-commit.hooks.shellcheck.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}
