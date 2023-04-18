---
date: "2023-02-06T14:54:34+02:00"
published: true
tags:
- post
- fosdem
- conference
title: Conference report FosDem 2023
---
# Conference report FosDem 2023

I was really happy to be back in Brussels finally, after some cancelled years due to Covid.
The official beer event at Delirium was still cancelled, but a bunch of us still
gathered there on Friday afternoon. Was great to see old friends from the Open Source
community, but I still managed to get to the ULB on Saturday morning in time for my first talk.

## Saturday

## Drawing k8s the right way

Not a mind blowing beginning, but some nice suggestions for diagramming Kubernetes clusters,
like shaded boxes/color usage, creating things as zones rather than graphs with lines,
and to be sparing with the official icon set, as they are very sharp. Also a good suggestion,
split up a complicated drawing into two simpler ones.

### Send in the chowns()s

This talk was a lot more low level, covering how OpenShift and eventually k8s is adding support
for virtual uid ranges mapped into the host UIDs through the use of Linux user namespaces.
This allows things like safely running systemd inside a docker container for legacy apps.
Hoping I won't need this, but still an interesting talk.

### Dagger CI in Go

This one is quite interesting. Dagger is a portable CI toolkit by the creators of Docker.
I've tracked this earlier but dismissed it due to introducing an obscure DSL (Cue), but
in the meantime they've introduced native SDKs to Dagger for several popular languages
including Go, Node and Python. This talk was about the Go variant, and it seems
rather usable despite a failed live demo,and provides some convenient functionality for
caching and using containers to create an isolated CI run that's the same across your laptop
and the CI runtime env.

### Delve - Debugging go with eBPF

This talk was about recent developments in the go debugger Delve. I def need to set this up
for my neovim config. However the most interesting part of the talk was covering the new
  eBPF backend for tracing. It's a lot faster than the existing ptrace backend, and in
  some cases you can go from seconds of overhead to microseconds.

### Tinygo.org/bluetooth

This was a really funny and interesting talk about using tinygo on embedded devices,
including lora chipsets for long range communications. They also launched a balloon the
day after to demonstrate this. Tinygo def seems like a fun time to try for my next Arduino
project.

### Bottlerocket

Bottlerocket is a container focused os for Kubernetes sponsored by AWS. It's created to have
fast spin-up time compared to a traditional os like AWS Linux 2, and is def something I would
look at when setting up an EKS cluster for GitHub Actions. The talk went through some details on
how well protected the inner core of the os is, as well as strategies for keeping it up to date.
(updog and more :)

### Headscale

This was my last track of the day in the Go Room. It's about an open source implementation of
Tailscale coordination/discovery service. Their clients are actually open source, so with this
in place you can run a fully open source tailnet. Interestingly one of the contributors Kristoffer
is a Norwegian who works for Tailscale in their technical staff, and apparently they fully
support and collaborate with the Headscale project.

The talk also has some interesting points about how they used integration tests to improve their
compability with the canonical implementation.

This was my last talk of Saturday, and I spent some time attending the various booths around
the campus, as well as some delicious Beligan brews ;-)

### Honorable Mention: Aurae

I really wanted to see the talk about Aurae in the Rust track (A new distributed pid 1 for
container runners) but Unfortunately the room was packed. Luckily the recording is already
on YouTube: <https://www.youtube.com/watch?v=5a277u4j6fU>

## Sunday

Was back fresh and early for the first talk at 9:00 on Sunday:

### Async in Python

This talk was by one of the Python core contributors, and covered a lot of details about
how async vs threads is working in Python, as well as details of the asyncio framework
included in Python3. In general this is similar to node's promises, but yet slightly
different. One interesting asyncio function is to_thread() (Added from 3.9+) to run blocking
workloads as a separate thread in the runloop.

He also recommended looking at FastAPI and Tariflette / Strawberry for async python
rest / graphql frameworks.

### Accelerating object serialization

I only stayed for this talk in the Python room because I had a gap for my next talk, it was
mostly about optimizing object serialization and json serialization through low level
tricks and using the native binary representations, with some serious offsets. Tbh
it wasn't too interesting to me, seems they should pick better tools for their job.

### Observability in Postgres

This talk was about using `postgres_exporter` to monitor Posgres from Prometheus, which
is something we should probably look into for cloud services as well as our database traffic
grow. It was also about some future developments of a internal postgres prometheus exporter,
but this seems rather further away. Likewise it covered some potential support for postgres query
tracing for opentrace and such.

### OpenTelemetry with Grafana

This talk was mostly a nice overview of the main components of the Grafana Observability stack,
including Loki, Tempo, Mimir and Grafana. Mostly known things to us, but interesting to see
how things intereacted, showing how you can follow a traceid from loki into tempo for instance
It also covered some basic of TraceQL. Held by one of the Grafana Labs Engineering managers,
and a smooth experience.

### A practical intro into OpenTelemetry

This talk went more into detail about how you can get OpenTelemtry collection by just
including the Agent for JDK and python services. It also covered some parts of the
added complexity for envs without a virtual machine like Rust, and mostly the same caveats
hold through for golang, which means you have to do some work to get the traces.

## The rest of the Sunday I spent in the Nix Track

Unfortunately it had a too small room without speaker and with not enough air,
so you probably will get a better experience watching the video than I did in that room.
After a quick intro we went into:

### NixOS is Great

Which was mostly a talk about an ephemeral homelab setup using nixos and pixicores.
The talk was mostly focused on netbootin diskless machines and didn't really cover
that much nix content.

### Pitfalls of Nix

This talk was about some of the pitfalls of nix and how to avoid them. Unfortunately
he didn't have great ideas for the high learning curve and cryptic stacktraces that
sometimes plagues nix users, other than a nice link to the awesome nix github repo
The talk also included some nice hints about using sops-nix for secrets management in
your repo to ensure secrets are kept away from the store.

### Make anyone use nix

Just a funny story about how someone made HR install nix to run their script.

### Nixel

This talk was about using Nickel as a replacement language for nix. The nickel programming
language seems a lot more sense than nix, so they had some
compelling arguments, but it's still missing flake support, so not quite ready
for my needs. Will be following nickel-lang/nicker-nix and hoping for quick improvements :)

### Playing with  Nix in adverse HPC

This talk was about university usage of nix in high performance computing. It had
some interesting ideas like letting nodes share a store with nix_store serve, as well a
using `rpmextract` to repackage rpms into nix. They also wrote a simple nix-wrap script
to allow sandboxing nix packages. Should be available with the notes on fosdem.org

### Contracts for free

Another talk about implementing simple type checking for nix. Yants by my friend [tazjin](https://tazj.in/)
is already prior art here, and it was unclear if contracts adds any significant benefit
over just using yants. Still a cool talk :)

### Devenv.sh

A talk by the devenv author, who's also behind cachix.org and nix.dev - Was pretty
nice to see that he's still serious about devenv, and the talk goes through some basics 
of setting up a devenv for development and ci. Devenv by now supports 36 different programming
languages.

## Going home

After that I was out of air. And spent the rest of the afternoon picking up a few stickers
and saying hi to old friends from the Perl community. All in all Fosdem 23 was a great
conference to me. One of the challenges tho with so many developer tracks is there's always
good talks you're missing. However luckily fosdem films most of it and publishes online, so they
will eventually all be available at <https://fosdem.org/> meanwhile all of the nix talks
mentioned above are already online on [Youtube](https://www.youtube.com/playlist?list=PLCRHeqSHTVIkbMv2kDnosX3JcIT_zJuST).
