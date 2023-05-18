+++
title = "Manage Hugo With Devenv"
tags = [ "post","meta", "Devenv" ]
categories = [ "blog"]
date = "2023-05-18"

draft = false
comments = true
+++
[`Devenv`](https://devenv.sh) is a nice tool for maintaining your dev environments, spinning up servers, adding
`pre-commit`-commit hooks and so on. I've been using a bit for maintaining my
[`nix-config`](https://github.com/marcusramberg/nix-config), as well as some work projects, so while reviving my blog from
it's slumber, I figured I could use it to improve my setup a bit.

`Devenv` uses `direnv` to install required packages when you enter the project, so we can as least use it to install
`Hugo`. Also, a spell checking dictionary could be handy?

``` nix
  packages = with pkgs; [
    hunspellDicts.en_US
    Hugo
  ];
```

I normally use `en_DK` as my locale, so in order to get the spellchecking to work we can also override the locale:

``` nix
  env.LANG = "en_US.UTF-8";
```

And the last piece is hooking up pre-commit hooks for markdown linting and spell checking

``` nix
  pre-commit.hooks = {
    actionlint.enable = true;
    hunspell.enable = true;
    markdownlint.enable = true;
  };
}
```

Note that I'm also running these checks in `GitHub Actions` with `devenv ci`, because why not? :)

`Devenv` also has a standard way of running servers:

``` nix
  processes = {
    hugo.exec = "hugo serve";
  };

```

In `Hugo`'s case it's not a big deal, but it's nice to have a standard way, specially if you want to add some extra
flags or whatever.
