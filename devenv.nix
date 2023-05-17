{ pkgs, ... }:

{
  # https://devenv.sh/basics/
  env.LANG = "en_US.UTF-8";

  # https://devenv.sh/packages/
  packages = with pkgs; [
    hunspellDicts.en_US
    hugo
  ];

  # https://devenv.sh/scripts/
  scripts.new.exec = ''
    POST=content/post/$(date +%Y-%m-%d)-$1.md
    hugo new $POST
    nvim $POST
    git add $POST
    git commit -am"Add $POST"
  '';
  processes = {
    hugo = "hugo serve";
  };

  enterShell = ''
    hugo
  '';

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks.markdownlint.enable = true;
  pre-commit.hooks.hunspell.enable = true;

  # https://devenv.sh/processes/
  # processes.ping.exec = "ping example.com";

  # See full reference at https://devenv.sh/reference/options/
}
