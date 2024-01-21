---
date: "2015-01-07T00:00:00Z"
link: http://www.thinkwiki.org/wiki/Buttonless_Touchpad
published: true
tags:
  - from_ios
  - Linux
  - ThinkPad
title: Fixing the ThinkPad Button-less Touch-pad
---

> The default configuration of the xf86-input-synaptics driver makes the touch-pad almost unusable (on the T440s).
> Clicks/Taps do not register properly, mis-clicking, no palm detection, no soft buttons where they should be, and so
> on...
> The following configuration can be put in `/etc/X11/xorg.conf.d/99-synaptics.conf` As a result the touch-pad will be
> a lot more 'calm' than before and the middle & right click button areas match with the printed ones on top of the
> touch-pad.

New laptop, new woes
