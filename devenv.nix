{ pkgs, lib, ... }:

{
  env.LANG = "en_US.UTF-8";

  packages = with pkgs; [
    hunspell
    hunspellDicts.en_US
    hugo
  ];

  scripts.mkpost.exec = ''
    POST=content/post/$(date +%Y-%m-%d)-$1.md
    hugo new $POST
    nvim $POST
    git add $POST
    git commit -am"Add $POST"
  '';

  processes = {
    hugo.exec = "hugo serve";
  };

  enterShell = "hugo";

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    actionlint.enable = true;
    hunspell.enable = true;
    hunspell.files = lib.mkForce "\\.md$";
    markdownlint.enable = true;
  };
}
