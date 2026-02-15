---
title: Mocking Up Locksmith 2 with PwshSpectreConsole
creation_date: 2025-03-22
modified_date: 2026-02-15
---
## Feeling Good Again!

The last couple months have been a bit hectic for ol' Jake (see also previous blog "New Job! New MVP?"). Also, I had the flu for the last two weeks which really put a damper on my style. But even with the flu, my life seems to be settling into its new routines, and I'm beginning to find my way at work. All of this has left me with a rather positive mental attitude.

When I am feeling good, I start doing handyman jobs around the house and designing PowerShell tools.

### Working With My Hands

Saturday afternoon, I installed a new toilet seat with an integrated bidet on our big bathroom toilet. Then I moved the old soft-close seat (previously installed on the large bathroom toilet) into our small bathroom. I also replaced a few torn and brittle roller shades with new room darkening versions. (Side note: my bedroom is *so much* darker now. If you aren't sleeping in a super-dark room, you're robbing yourself of sleep.)

![]({{ site.baseurl }}/images/NOTDarkRoom.png)
If your room looks like this when you go to bed, buy some plywood.

### Working With My Brain

As for PowerShell tools, the only tool in my immediate radar is Locksmith 2. I'm going outside of my comfort zone in so many ways with LS2. I did research and took notes. I wrote up a product requirements document. I'm requirining a TUI and improved reporting. These are not things I'm good at. But I'm rarely one to back down from a challenge.

I spent most of my Saturday morning and bit of my Sunday afternoon playing with PwshSpectreConsole ([https://pwshspectreconsole.com](https://pwshspectreconsole.com)), a PowerShell 7 wrapper for the Spectre.Console .NET library. In that time, I went through the entire PwshSpectreConsole site page by page to read and understand how to use the module.

![]({{ site.baseurl }}/images/PwshSpectreConsole.com.png)
  
I can safely say after playing with PwshSpectreConsole for 4-5 hours, it will greatly improve the UI/UX of most Powershell 7 scripts and console-based tools. This module makes it so much easier to build menus and tables, to format text, and to create renderable items like bar charts and modern progress indicators. But most importantly 🤣, PwshSpectreConsole makes it easy to use emojis. 🥲

After playing with it this weekend, I'll definitely be using it for the text-based user interface for Locksmith 2! Thanks to [Shaun Lawrie](https://shaunlawrie.com) for building such a useful thing.

Next up: I'm going to talk how I'm writing the pseudocode for Locksimth 2!



