+++
title = "Managing Hugo With devenv"
date = "2024-01-21"
tags = [ "post", "hugo", "devenv" ]
categories = ["blog", "nix"]

comments = true
draft = false
+++

I am using the [Hugo](https://gohugo.io/) static site generator to generate this blog. I am also using
[devenv](https://devenv.sh) to manage my development environments. This also includes the
[blog](https://github.com/marcusramberg/blog/). This ensures I can easily build and run the blog locally, and keep up to
date with the latest Hugo version, without having to install anything on my host system. Devenv also provides easy
integration with [pre-commit](https://pre-commit.com/) to allow linting of the markdown files, and CI integration with
GitHub Actions.

```nix
  pre-commit.hooks = {
    actionlint.enable = true;
    markdownlint.enable = true;
  };
```

Devenv activates the environment when I enter the directory, and deactivates it when I leave it. through the use of
`direnv`.This ensures I have the
correct version of Hugo available when I am working on the blog.

Devenv is also convenient for managing small shell scripts. I have a mkpost script that creates a new post for me:

```nix
    mkpost.exec = ''
      POST=content/post/$(date +%Y-%m-%d)-$1.md
      hugo new $POST
      nvim $POST
      git add $POST
      git commit -m"feat: Add $POST"
    '';
```

as well as a simple script to add a image from my clipboard to the blog:

```nix
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
```

This is super convenient for adding screenshots to the blog, and keeps those screenshots in my environment only while
I'm working on the blog.

<img alt="screenshot" src="/images/2024-01-21-screenshot.png" width=700/>

If you're interested in using devenv, check out the [getting started guide](https://devenv.sh/getting-started/), and my
devenv [configuration](https://github.com/marcusramberg/blog/blob/master/devenv.nix) for using it with hugo.
