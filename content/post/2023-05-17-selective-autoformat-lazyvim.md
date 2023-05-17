+++
tags = [
    "nvim",
    "lazyvim",
    "autoformat",
]
categories = [
    "neovim",
]
date = "2023-05-17"
title = "Disabling nvim autoformat on a per-repo basis"
published = true
comments = true
+++

I'm a huge fan of Folke's Neovim distribution [lazyvim](
https://www.lazyvim.org/). It has replaced my own custom lua config, and
reduced the time I'm spending tweaking my config by a lot.

One nice thing is it enables format on save by default,
which is actually what I want for almost all things. However in some repos I
contribute to they frown upon this behavior, so I have to constantly remember
to turn it off with `<space>uf` or suffer review comments about excessive
white-space fixes :)

That kinda works, but I sometimes forget, and have to undo after save and turn
it off. However now I have [a better
solution](https://github.com/marcusramberg/nix-config/commit/ca25bedf9a2d5516fd8131f1c99467538f7a7ffa):

``` lua
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  attern = vim.fn.expand("~") .. "/Source/{nimdow,nixpkgs}/*",
  callback = function()
    vim.b.autoformat = false
  end,
})
```

Add this to `autocmd.lua` and whenever you enter a buffer inside `nimdow` or `nixpkgs`
it automatically turns off autoformat. Note how I'm expanding ~ in this scenario
rather than putting in `/home/marcus` to ensure it works on MacOs as well as Linux.
