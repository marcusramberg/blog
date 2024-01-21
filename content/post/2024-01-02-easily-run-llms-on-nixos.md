+++
title = "Easily Run LLMs on nixOS"
date = "2024-01-02"
tags = [ "post", "llm", "nixos" ]
categories = ["nixos"]

comments = true
published = true
+++

With the recent AI craze, it's fun to play with local models. I like [ollama](https://ollama.ai/),
which lets you easily download and interact with various models. Thanks to this
recently merged [PR](https://github.com/NixOS/nixpkgs/pull/277442), it's now trivial to run your own ollama
service on nixos:

```nix
services.ollama.enable = true;
```

Adding this to your host config and rebuilding is all it takes to start the service,
and you can then interact with it via the cli or rest interface. For instance to talk
to the [mistral](https://mistral.ai/product/) model, you can do:

<img src="/images/2024-01-02-mistral.png"  width="720" alt="ollama run mistral"/>

On first run it will automatically download the model, and then you can interact with it.
They support a [bunch of models](https://ollama.ai/library/), so have fun exploring! If you
are of that inclination, there's also a [neovim plugin](https://github.com/nomnivore/ollama.nvim).
