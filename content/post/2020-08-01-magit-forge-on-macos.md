---
author:
  - Marcus Ramberg
draft: false
publishDate: "2020-08-01T00:00:00+02:00"
tags:
  - emacs
  - github
title: Magit Forge on macOS
---

I've tried many editor git integrations over the years, in Vim, VS Code, Intellij, Sublime, as well as various git GUIs.
However I've never found something nearly as powerful and efficient day to day as working on the command line.

While I will probably never give up the command line, with Emacs' Magit I've finally found a valuable companion which
feels as powerful and efficient as the cli interface. The magit status window is a super powerful base point for most
git operations. And with Magit Forge you can make it even more powerful.

Now, to use Forge you need a github token. On macOS the best place to store such secrets is the OS Keychain, so I
contributed [a pull request to doom emacs](https://github.com/hlissner/doom-emacs/pull/3311) to make it support the
keychain for auth storage. Check out the [MacOS doom
module](https://github.com/hlissner/doom-emacs/tree/develop/modules/tools/macos) for more documentation.
