---
author:
- Marcus Ramberg
draft: false
publishDate: "2020-06-21T00:00:00+02:00"
tags:
- homeautomation
- diy
- garden
title: 'Weekend Project: Z-wave controlled Solenoid valve for watering'
---

Recently, I've set up a manual micro-drip system for our green house and flowers. I've been meaning to do something to automate watering schedules for our the micro drip system and our lawn and even ordered a solenoid valve from the internets a while back. It arrived a couple of weeks ago, and with a rainy sunday, I was finally ready to tackle this project.

{{<figure src="/images/wiring.jpg" alt="Valve control wiring">}}

Basically I just combined a z-wave light switch with the solenoid switch, stuffed it into a waterproof box and connected it to the water hose. I also added some heat shrink with glue to waterproof the solenoid sensor. I took some leftover connectors I had to attach it to a garden hose connector. Presto:

{{<youtube id="ffNVmQsQRH0" autoplay="true">}}

Now with this setup I can easily set up home assistant automations to do watering schedules while we're on vacation, and even integrate with YR to skip rainy days. And no cloud required :) Also, if it short circuits for some reason, it will default to being off. As a potential improvement I'm considering adding a flow gauge so that I can measure how much water I'm pouring into the garden, and to shut it down if there's suddenly a drastic flow increase.
