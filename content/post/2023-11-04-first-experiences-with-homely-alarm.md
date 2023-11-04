+++
title = "First Experiences With Homely Alarm"
date = "2023-11-04"
tags = [ "post" ]
categories = ["reviews"]

comments = true
published = true
+++

For the last few years, we've had managed alarm service from [Sector Alarm](https://www.sectoralarm.no). It's mostly
been OK, but the price has been increasing every year, and they never upgrade our components,
so when I learned about the offering from [Homely](https://homely.no), I was intrigued.

Basically you own your own components, and pay a monthly fee for monitoring. The components
are mostly `Zigbee`-based, and there's a home assistant integration to get the status into my
home assistant setup, so I decided to give it a go.

That was about 3 months ago, and our agreement with sector alarm finally expired last week, so
I've been busy replacing the old components with the new ones. The new components are mostly smaller
and nicer looking, it's all paired to their proprietary hub, and it's all managed through their app.

Pairing through QR code mostly worked OK, even tho it sometimes took quite a while to find the devices.
I think the app is some sort of web-view, and it's not the most responsive thing in the world, but it
mostly works OK. We have two Yale Doorman components, and after factory resetting the door locks, they
also integrated nicely with the new `Zigbee` modules. I think the integration with the door locks could
be better.

You have to set door codes separately for each door lock, but now that it's done, it's working
OK, and you can configure it so unlocking a door disables the alarm. Next up is running a test of the installation to
check that all the sensors are working as expected, and then setting up the home assistant integration.

They support a list of components, and I think it's possible to use other `Zigbee` devices, but I haven't
tested yet. Honestly I wish they had some way of integrating with my existing `Zigbee` network, for instance
by having a `MQTT` interface, but I guess that's not their target audience.

Will report back when we have some more experience with the system, but all in all, I'm happy with the
experience so far, specially the savings on the monthly fee.
