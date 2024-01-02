{ pkgs, lib, ... }:

{
  env.LANG = "en_US.UTF-8";

  packages = with pkgs; [
    hunspell
    hunspellDicts.en_US
    hugo
    nodePackages.markdownlint-cli
  ] ++ lib.optional stdenv.isLinux xclip ++ lib.optional stdenv.isDarwin pngpaste;

  scripts = {
    mkpost.exec = ''
      POST=content/post/$(date +%Y-%m-%d)-$1.md
      hugo new $POST
      nvim $POST
      git add $POST
      git commit -am"Add $POST"
    '';
    pasteimg.exec = ''
      FILE=static/images/$(date +%Y-%m-%d)-$1.png
      if [ -x "$(command -v pngpaste)" ]; then
        pngpaste $FILE
        echo "<img src=\"/images/$(basename $FILE)\" width=700/>" | pbcopy
      else
        xclip -selection clipboard -t image/png -o > $FILE
        echo "<img src=\"/images/$(basename $FILE)\" width=700/>" | xclip -selection clipboard
      fi
    '';

  };

  processes = {
    hugo.exec = "hugo serve";
  };

  enterShell = "hugo";

  # https://devenv.sh/pre-commit-hooks/
  pre-commit.hooks = {
    actionlint.enable = true;
    # hunspell.enable = true;
    # hunspell.files = lib.mkForce "\\.md$";
    markdownlint.enable = true;
  };
}
