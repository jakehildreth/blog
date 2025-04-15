---
title: My macOS Non-Negotiables
creation_date: April 6, 2025
modification_date: April 13, 2025
---
## Intro
[As previously discussed](_posts/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon.md), I'm a macOS-first user. Windows and Linux and [TempleOS](https://github.com/cia-foundation/TempleOS) each have their time and place, but I'm most comfortable in front of a Mac. Over the past 19 years of Mac use, I've modified almost everything about my Macs' setups. Thanks to Time Machine, those mods persist from old machine to new machine. Unfortunately, the quirkiness of my machine sometimes results in being confused by Macs in a more pristine state like my wife's Mac (almost stock standard!)

I recently got a new MacBook Pro (with an M4 Pro!) from work. As I pulled the chonky boy out of its box, I made a conscious decision to avoid transferring 19 years of technical baggage to it. Instead, I've decided to document the bare minimum software I need on a Mac to feel productive - and a few less-necessary but still important packages.
## The tl;dr
- Better Versions of macOS Features
	- Alfred - [alfredapp.com](https://alfredapp.com)
	- Rectangle - [rectangleapp.com](https://rectangleapp.com)
	- ~~SlowQuitApps - [github.com](https://github.com/dteoh/SlowQuitApps)~~
	- Hammerspoon - [hammerspoon.org](https://www.hammerspoon.org)
- The Package Manage that Should Exist in macOS
	- Homebrew - [brew.sh](https://brew.sh)
- Development Stuff
	- git- [git-scm.com](https://git-scm.com/downloads/mac)
	- Powershell 7 - [github.com]([https://github.com/PowerShell/PowerShell](https://github.com/PowerShell/PowerShell))
	- Visual Studio Code - [code.visualstudio.com](https://code.visualstudio.com/docs/?dv=darwinarm64)
	- VS Code PowerShell Extension - [marketplace.visualstudio.com](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)
	- Terminal.app SpaceGray Theme - [github.com](https://github.com/lysyi3m/macos-terminal-themes)
	- JetBrains Mono Font - [jetbrains.com](https://www.jetbrains.com/lp/mono/)
- Working with Windows
	- Windows App - [Mac App Store](https://apps.apple.com/us/app/windows-app/id1295203466?mt=12) or [microsoft.com](https://go.microsoft.com/fwlink/?linkid=868963)
	- UTM - [getutm.app](https://docs.getutm.app/installation/macos/)
- Everything Else!
	- Camo Studio - [reincubate.com](https://reincubate.com/camo/)
	- Logi Tune - [logitech.com](https://www.logitech.com/en-us/video-collaboration/software/logi-tune-software.html)
	- Mattermost - [mattermost.com](https://mattermost.com/apps/)
	- Discord - [discord.com](https://discord.com)
	- Slack - [slack.com](https://slack.com)

## Better Versions of macOS Features
When I first started using a Mac, I was so confused by most of the interface choices. But after a few months, I let go of my hangups and just went wih the vibes. Things generally feel smoother on a Mac than on Windows, though Windows 10/2016 and higher are pretty smooth too.

However, there are a few features that can still be improved over the out-of-box Mac experience. Let's talk about those first!
### Alfred - [alfredapp.com](https://alfredapp.com)
![]({{ site.baseurl }}/images/Screenshot%202025-04-12%20at%209.08.29%20AM.png)
At first glance, Alfred looks like a simple replacement for Spotlight, the search bar built into macOS. If you've never used Spotlight, try it today by pressing Command + Space and typing a partial filename. Spotlight searches your local storage/iCloud for files and folders that match your search term. And if it can't find a match, Spotlight can do Google searches or perform basic calculations and conversions instead. Also there's some Siri integration but ¯\\\_(ツ)\_/¯

Alfred does all that but also can:
- search specific websites instead of just searching Google
- perform more complex calculations
- provide definitions of words
- search your contacts
- store a clipboard history
- provide snippet expansion (i.e. I can type @today which expands to April 6, 2025)
- and a ton of other neat things I use daily
![]({{ site.baseurl }}/images/Pasted%20image%2020250412090650.png)
But the most important thing I like about Alfred is its "workflow" functionality. By creating or installing a workflow, you can fire off multi-step processes to do things like control external applications, start timers, add items to your calendar, reconnect your AirPods, or to do basic DNS lookups without opening a shell or browser.

I will never work consistently on a Mac that is missing Alfred.
### Rectangle - [rectangleapp.com](https://rectangleapp.com)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412090606.png)
One fateful day, I randomly discovered how to snap windows to the sides of the screen in Windows 7. I don't remember if I learned about the "drag to the side" shortcut or the Windows Key + \<arrow> key shortcut first, but I eventually began to use both consistently. I could replicate dual monitor functionality and increased productivity on a single monitor.

I immediately tried to find similar functionality in macOS but was sorely disappointed. Thankfully I wasn't the only one to want this feature; an internet person named "eczarny" wrote a small piece of software called Spectacle which added snapping to the Mac.

Spectacle was great, but it stop being maintained. I prefer to avoid unmaintained software where possible. A quick search revealed Rectangle to be the new window manager of choice.

With a few easy-to-learn keyboard shortcuts, I could now snap to my heart's content. I especially like Rectangle's top-right/top-left/bottom-right/bottom-left shortcuts for breaking a screen into 4 windows. Yes, I usually have 4 windows open simultaneously now. 🤦

>Note: macOS didn't have window snapping natively until **2024**!

### ~~SlowQuitApps - [github.com](https://github.com/dteoh/SlowQuitApps)~~
I really want to know who decided to put the "Switch Applications" shortcut (Command + Tab) and the "Close Window" shortcut (Command + W) right next to the "Quit Application" shortcut (Command + Q). This configuration probably made sense until the advent of tabbed interfaces. Since then, it's caused me so much strife. Usually I just want to close the current tab, not all the tabs!

Google Chrome was the first appliction I ever saw to include a "Warn before Quitting" function which requires you to press and hold Command + Q for about a second before the main application actually closes. Errant presses of Command + Q that were supposed to be Command + W were a thing of the past.

Thankfully, someone came up with a tiny helper application that adds this function to all applications: SlowQuitApps (SQA). Unlike the Chrome version, SQA adds 2 cool features:
- configurable delay length before the application actually quits
- onscreen countdown timer
I'm pretty quick at realizing when I typed the wrong thing, so I have my timer set to 500ms. During that 500ms, the onscreen timer shows me I'm pressing Command + Q. If I meant to be press something else, I will see the SQA indicator and release the keys. 

This tiny app has saved me from myself so many times. Unfortuantely, it appears to be falling out of maintenance much like the aforementioned Spectacle.
### Hammerspoon - [hammerspoon.org](https://www.hammerspoon.org)![]({{ site.baseurl }}/images/Pasted%20image%2020250412091136.png)
While writing this blog, I could not get SQA to work. It kept asking for access to Accessibility settings every time I opened the app. While doing a little research to find out what was wrong, I came across another app called Hammerspoon which makes it a little easier to directly interact with various Mac APIs for the purposes of automation via small Lua scripts. I have no idea how to write Lua, but Stack Overflow provided me with everything I needed to replace SQA functionality. So far, it's working well. Expect a report soon.
## The Package Manager That Should Exist in macOS
> A _package manager_ keeps track of what software is installed on your computer, and allows you to easily install new software, upgrade software to newer versions, or remove software that you previously installed. As the name suggests, package managers deal with _packages_: collections of files that are bundled together and can be installed and removed as a group. [source](https://web.archive.org/web/20171017151526/http://aptitude.alioth.debian.org/doc/en/pr01s02.html)

With even moderate Linux experience, you're likely to come across a package manager. More likely, you'll come across multiple package managers: `yum`, `apt`, `dnf`, `pacman`, `portage`, `zypper`, `Nix`. Windows even has a couple package managers, though, most users won't run into them: `choco`, `scoop`, `winget`.
### Homebrew - [brew.sh](https://brew.sh)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412091332.png)
I get the vibe that traditional package managers used to go against some of the core tenets of the Mac experience. But I like package management from the command line, so I had to find something that replicated package management experiences from Linux. For a while, the most popular package manager was Macports so that's where I started. It's been around since 2002 and is well-supported by many popular development packages. But over time, I got tired of messing with broken packages, conflicts, and generally managing the package manager instead of just DOING stuff.

By then, Homebrew had gotten off the ground and was doing cool stuff. I installed it, uninstalled Macports, and never looked back. Yes, it's kind of silly to call GUI tools "casks" and separate repos "taps", but I like software that feels like it was made by humans instead of corporate drones. The maintainers added an easy-to-use searchable website a few years back which made its usage even easier. 

BTW: tying applications together, I can use Alfred to search https://brew.sh for packages to install, and I used Homebrew to install SlowQuitApps and almost all the stuff I use for development.
## Development Stuff
I'm not a developer, but I do a lot of development. So, this is all very basic stuff, and I'm sure some more seasoned developers will have opinions about my setup. That's *fine*.
### git - [git-scm.com](https://git-scm.com/downloads/mac)
If you're not familiar with git, you probably will never need it. But if you are familiar, you probably don't need any explanation from me. In short, it's distributed version control system that allows multiple developers to work on code simultaneously and (mostly) not interfere with each other's work. I didn't really use git until late 2021 when I first submitted a pull request for the PSPKIAudit package. Since then, I've grown to *think* in git terms. It's very strange.
### PowerShell 7 - [github.com]([https://github.com/PowerShell/PowerShell](https://github.com/PowerShell/PowerShell))
PowerShell had it's first production release in November 2006 and has been integrated into all versions of Windows since Windows 7/Server 2008 R2. In that time, it has become irreplaceable in the eyes of many IT folks. With the release of PowerShell Core in August of 2016, `pwsh` was release as an open-source project which added cross-platform capabilities. I actually replace the Mac's default shell (`zsh`) with PowerShell.
### Visual Studio Code - [code.visualstudio.com](https://code.visualstudio.com/docs/?dv=darwinarm64)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412091421.png)
When I first started writing PowerShell, I did it in Notepad++ which was terrible. Then I moved to SublimeText which was less terrible but still not my favorite. For a second, I used Sapien's PoweShell Studio which was actually really cool for making GUIs using a WYSIWYG editor.

But when I started working at Trimarc in August 2021, I was introduced to Visual Studio (VS) Code. I've never looked back. Extensions make it super-easy to add new or enhanced functionality, and I even use the built-in debuger sometimes!

With a little customization and the next item on this list, I feel like I could conquer the world with my scripts. 
### VS Code PowerShell Extension - [marketplace.visualstudio.com](https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412091602.png)
VS Code has decent support for many popular languages out of the box, but to use it to its fullest extent, you have to extend it. Thankfully, the PowerShell Extension is *fantastic.* It adds configurable syntax highlighting, support for multiple brace styles (OTBS or GTFO tho), Intellisense, PowerShell Script Analyzer problem reporting, an ISE mode if you want to go retro, and a ton of other quality of life improvements
### Terminal.app Space Grey Theme - [github.com](https://github.com/lysyi3m/macos-terminal-themes)
[![Screenshot](https://github.com/lysyi3m/macos-terminal-themes/raw/master/screenshots/spacegray.png)](https://github.com/lysyi3m/macos-terminal-themes/blob/master/screenshots/spacegray.png)
The built-in color themes for Terminal.app are terrible. For a company so focused on a slick user experience, I would expect more from Apple. But really, they're garbage.

Thankfully, someone named Emil Kashkevich (https://github.com/lysyi3m) created a repository of Terminal.app themes. Almost every single one is better than the built-in themes, but I particularly love the one named "Space Grey".
### JetBrains Mono Font - [jetbrains.com](https://www.jetbrains.com/lp/mono/)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412091650.png)
I was turned on to this font by the former director of development at Trimarc. He shared his screen, and I went "ooooooh" when I noticed how easy it was to read this font. I use it almost anywhere a monospace font makes sense.
## Working with Windows
I work in Active Directory related stuff all day every day. This means I need access to at least one Windows machine. Luckily, there have been multiple ways to do this successfully since I first started using Macs.
### Windows App - [Mac App Store](https://apps.apple.com/us/app/windows-app/id1295203466?mt=12) or [microsoft.com](https://go.microsoft.com/fwlink/?linkid=868963)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412091718.png)
The Windows App was formerly known as Microsoft Remote Desktop. It was reworked and rebranded recently and now supports connecting to some things that I have never used and have no interest in learning. 

But it also maintained the thing I need it for the most: remotely connecting to my corporate Windows machine.
#### Honorary mention: Devolutions Remote Desktop Manager - [devolutions.com](https://devolutions.net/remote-desktop-manager/)
If you connect to remote machines using protocols other than RDP, check out the Devolutions product including VNC, SSH, Apple's Remote Desktop protocol (aka sparkling VNC.)
### UTM - [getutm.app](https://docs.getutm.app/installation/macos/)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412091741.png)
I first started working with Macs when they switched to Intel chips. From the jump, Intel Macs supported Windows running in virtual machines (or via Boot Camp). But in 2020, Apple announced they were moving to custom Apple-manufactured ARM-based chips. This broke my ability to easily work with Windows for a couple years.

Have you ever tried to use QEMU to run a virtual machine? I haven't, but every time I look at its documentation, I get a nosebleed. Thankfully, some generous souls put a pretty wrapper around QEMU and made it much easier to work with. It's called UTM and it supports virtualization AND emulation (at a severe speed cost). If you're interested in running other OSes on Apple Silicon, this is one way to do it.
## Everything Else
Everything past this point is just quality of life stuff. If I didn't have them, I'm sure I could work just fine. But at what cost? 
### Camo Studio - [reincubate.com](https://reincubate.com/camo/)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412091857.png)
I started using Camo because it allowed you to use an iPhone as a webcam before Apple added Continuity camera. I keep using it because it's *so much* easier to do overlays and quick image adjustments than any other app I've used.
### Logi Tune - [logitech.com](https://www.logitech.com/en-us/video-collaboration/software/logi-tune-software.html)
I have a Logitech Brio, and the only way to enable its HDR support is through this app. It's fine.
### Mattermost - [mattermost.com](https://mattermost.com/apps/)
![]({{ site.baseurl }}/images/Pasted%20image%2020250412092403.png)
The Locksmith core team communicates on a Mattermost server that I run on Oracle Cloud. I might open it up to Locksmith users in the near-future if there's interest!
### Discord - [discord.com](https://discord.com)
Almost everyone I know in the cybersecurity community complains about the number of Discord servers they have to take part in, and I'm no exception. And I don't even join that many!
- [rand0h](https://www.linkedin.com/in/dakacki/)'s HackerStream
- Red Siege
- Four (4) BHIS-related groups
- PowerShell
- \[REDACTED\]
- PDQ
- [techSpence](https://www.linkedin.com/in/spenceralessi/)'s Ethical Threat

### Slack - [slack.com](https://slack.com)
Slack is where the BloodHound Gang hangs out. I'm not a BloodHound user, but there are some great conversations about Active Directory security there, so ya gotta join.
### Spotify - [spotify.com](https://spotify.com)
I frequently have music playing when I'm home alone. I probably should pay for a service that pays artists better, but I'm entrenched in the ecosystem for the time being.
## Conclusion
Starting fresh on a new Mac has been shockingly painless. I thought I'd need to bring over more of my "stuff" to feel comfortable, but taking a moment to evaluate what I actually use has been incredibly worthwhile. For sure this list isn’t exhaustive (I've definitely installed a few more pieces of software in the week since I started writing this article!), but it captures the tools and tweaks that make macOS feel like home to me without dragging along two decades of cruft.

If you're moving to a Mac from Windows/Linux, or you've decided to relieve yourself of your Time Machine chains, I hope this guide helps you find your footing. BTW: if you have essential software I didn’t mention, I’d love to hear about them! I'm always looking for new ways to improve my work environment. Send me an email: [jake@dotdot.horse](mailto:jake@dotdot.horse)

Happy configuring!