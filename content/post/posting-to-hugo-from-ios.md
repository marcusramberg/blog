---
author:
- Marcus Ramberg
draft: false
publishDate: "2020-06-12T00:00:00+02:00"
tags:
- hugo
title: Posting to Hugo from iOS
---

I like to take pictures, and some of the point for me of rebooting this blog was to have a place I control myself
to publish things, rather than relying on Facebook or Instagram to own my data. However, since my trusty iPhone is
my camera 99% of the time, that means I rely on having a simple way to post from the phone, otherwise it's just not
going to happen.

Luckily, with IOS 13, Power users have a much improved tool for these kind of workflows. I started writing my first
workflow, and was amazed by how easy and powerful it is. I was able to make a share extension for photos that just
asks for a post title and then posts directly to my github blog repo. [This
sunset](https://marcus.nordaaker.com/post/2020-06-11-oslo-sunset/) is an example of a post using this workflow :)

If you want to borrow my workflow, it's avilable through icloud
[here](https://www.icloud.com/shortcuts/99d972dc7de74d29aee41f1e089953c3) - I'll also go through it step by step to
quickly explain how it work

## Step by step {#step-by-step}

{{<figure alt="Workflow Part 1" src="/images/ios-hugo-photos-1.jpg">}}

- First I resize the photo to a more handy format, as the iPhone pictures out of the box takes about 2 MB, which is a
  bit much for a web page.
- Then I tell working copy to pull latest posts to make sure we're not behind
- We ask for a title and set that to a variable

{{<figure alt="Workflow Part 2" src="/images/ios-hugo-photos-2.jpg">}}

- Then replace spaces in the url to create a slug,
- Add the picture to static images in the blog photo with date formated as yyyy-mm-dd and our slug

{{<figure alt="Workflow Part 3" src="/images/ios-hugo-photos-3.jpg">}}

- Create a text document with the post content including publish date and the photo tag
- Write that to the corresponding post filename.
- Finally commit and push to remote.

To give credit where credit is due, most of the heavy lifting here is done by [Working
Copy](https://workingcopyapp.com/) - it's a fantastic and fully featured git client for ios. If you do anything with
git, it's worth buying.

## The Future {#the-future}

This workflow is enough for me to be able to do simple posts, but of course it could be improved. Things I'm
considering are allowing custom tags, and getting metadata from exif.
