---
title: macOS Screen Sharing.app Considered Harmful
creation_date: 2025-08-19
modified_date: 2026-08-30
tags: [macos, security]
description: "My first macOS security dig: why Screen Sharing.app deserves suspicion."
---
## Babby's First macOS Security Report
Despite being my daily driver at both work and home, I've never dug too much into macOS security. I very occasionally read stuff from Patrick Wardle, but he's the only macOS security researcher I can name. I have little idea how most of the macOS gooey bits operate, and honestly, I'm fine with it.

So... this article is weird for me. It's a dip into something I consider a pretty serious security oversight in the macOS **Screen Sharing.app**. In short, when a target Mac is being remotely controlled by another Mac using Screen Sharing.app's High Performance mode, **an attacker with physical access to the target Mac can take control of the active remote user's session without authentication.**
![surprised Pikachu]({{ site.baseurl }}/images/LezUBfV%20-%20Imgur.png)
>Please note: following standard responsible disclosure protocol, my concern was initially reported to Apple Security on May 7, 2025, but they deemed it "expected behavior." On May 22, 2025, I informed Apple Security of my intent to disclose this issue publicly.

I would totally understand if you read the description above and got excited about a cool new zero-day that uses hackery words like "hacking the mainframe" and "rerouting the encryptions". I'm sorry to report you'll find none of that here. This issue is an example of how differences between expected and actual behavior can give a user a false sense of security and lead to unintentional data disclosure.

Before I detail what I found, I feel the need to provide some context about why this finding surprised me. As always, if you don't want to read my blathering, I get it... [Skip to the good part!](#how-to-replicate)
## Remote Work
Despite using macOS for almost two decades, I didn't use Screen Sharing.app until maybe 2016. Since my work life was centered around Windows, most remote access was performed using Microsoft's Remote Desktop Protocol (RDP), PowerShell Remoting, or `psexec` ❤️. In those rare instances where I needed to connect to a computer that wasn't domain-joined, I would usually resort to TightVNC.

That changed when my employer stood up an Apple Mobile Device Management server on a Mac mini. Laugh all you want, but it was cheap, reliable, and worked well enough for its intended purpose. Our GIS department managed the system (don't ask), but they'd occasionally reach out to me for help with configuration and deployment, especially when certificates were involved. (Maybe they knew where I'd end up?)
![A certificate of Awesomess bestowed upon the author]({{ site.baseurl }}/images/Pasted%20image%2020250820181317.png)

After the third or fourth call for help, I decided I was tired of leaving my desk and trudging to the GIS office to work on the Mac mini. After a bit of research, I learned there was a remote access service available on every Mac, the remote access service (called Screen Sharing) was just a glorified VNC server, and there was something called Screen Sharing.app that was designed for communicating with Macs. Whoda thunk?

At that time, I only saw two differences between Screen Sharing.app and a basic VNC client:
1. **Better Keyboard Support:** Most VNC clients are designed with a non-Mac keyboard in mind. Common Mac keyboard shortcuts didn't work consistently in these clients, even when the local and remote computers were both Macs. In Screen Sharing.app, everything worked correctly.
2. **Improved Authentication System:** With a basic VNC server, there's no username required; a single password is all you need to view the screen of the remote computer. In contrast, when connecting from my work MacBook to the GIS Mac mini using Screen Sharing.app, I'd have to enter the local username and password I had configured on the Mac mini. Adding a little user separation was a nice touch and allowed me to keep my work separate from the GIS folks.

Ultimately, though, Screen Sharing.app was still fancy VNC. If one of the GIS dudes was sitting in front of the Mac mini's monitor while I was controlling it from my office, they could see everything I was doing.

In many work situations, this is acceptable, nay, preferred! For example, when I'm supporting others, I usually want them to see what I am doing so they can help themselves in the future! At other times, though, I prefer the privacy afforded by Microsoft's RDP. 

You see, when a remote user connects to a Windows computer using RDP, the local console/session locks. (I think the screen goes blank, too? It's been a while since I've done this, and I can't remember!) If a user with physical access to the Windows computer wants to use the computer while it's being remotely controlled, they need to enter valid credentials.  

Say what you will about many of Microsoft's products, RDP's behavior makes sense to me. It provides remote access capabilities and provides the remote user with some privacy. With High Performance mode, Apple addressed the privacy shortcoming in Screen Sharing.app... sort of.
## New Silicon = New Features
As mentioned earlier, Apple introduced High Performance mode in macOS Sonoma, which is also when Apple introduced their M line of chips designed for use in laptops and desktops. High Performance mode takes advantage of the new chips and is only supported when connecting between two Macs running on Apple Silicon.
![A stylized photo of an Apple M-series chip. It is a matte black square with a shiny Apple logo stamped on it.]({{ site.baseurl }}/images/Apple-Silicon-chips.jpg)

Instead of being jalapeño-spicy VNC like ye olde Screen Sharing.app, this mode is more like Scotch bonnet-spicy VNC! Seriously, it does add some great features:
- **Dynamic Resolution:** if you connect from a Mac with a big screen to a Mac with a small screen, the resolution can adapt (to a point) to the larger screen without stretching. If you connect in the opposite direction, no scrolling necessary!
- **Multiple Virtual Monitors:** the pre-Sonoma Screen Sharing.app only allowed you to see one monitor at a time. The new one allows you to see two... even if the Mac you are connecting to only has one monitor! It's very weird.
- **Improved Performance With Less-The-Optimal Connectivity:** in the original Screen Sharing.app, performance was basically unusable over slow and/or unstable connections (like over a VPN or Wi-Fi). High Performance mode works great in these conditions.
- **Sound Sharing:** sound is forwarded over the Screen Sharing session with shockingly low latency.
- **Privacy:** the screen is blanked out while a Mac is being remotely controlled.

That last feature made me very happy. Privacy is now part of the preferred mode, but the original unblanked screen method remained available via "Standard Performance" if I needed to remotely access a Mac with someone else viewing the screen.
## Unexpected Insecurity
Now, whenever I need to control one Mac with another Mac, I pop open Screen Sharing.app and fire up a High Performance session. Whether I'm playing music from a central location, checking the status of some large uploads/downloads, or swapping Messages with my wife, I can stay at a single computer. Very nice.

But sometimes I'm an idiot...

And I walk away from one Mac without disconnecting my Screen Sharing session...

And I walk to the other Mac to use it...

And a robot lady yells at me: "YOUR COMPUTER IS BEING REMOTELY CONTROLLED! PRESS THE ESCAPE KEY TO STOP THE CONNECTION!"
![A screenshot of an advertisement for an app named "Yelling Robot for Mac"]({{ site.baseurl }}/images/Pasted%20image%2020250820182109.png)
<sub>Not this yelling robot.</sub>

For the first few weeks of experiencing this behavior, I would hear the robot lady yelling at me and laugh at myself for being a sillybilly. After a few sensible chuckles, I'd press the Escape key as directed and complete whatever task I'd originally intended to do.

But then it hit me...

*After pressing Escape, I was dropped directly into the live interactive session I had just been controlling remotely from my other Mac.* **At no point was I forced to authenticate at all.**
## Wait... That's It?
This may not seem like much of a security issue at first glance. I got access to an active session *initiated by me* on a *computer I own* without authenticating... who cares? 🥱 I could even see someone arguing this behavior is a good thing. It makes Screen Sharing easier to use!

Take a moment to imagine you are working on your MacBook Pro in a coffee shop and using Screen Sharing.app to connect to your Mac Studio back home. A burglar breaks into your home and bumps the keyboard on your desk. A robot voice shouts at him, telling him exactly how to gain access to your computer. He presses the Escape key on the keyboard and gets access to all the files stored on your computer, browsing history, Photos library, iCloud, etc.
![A stylized graphic of a masked man hanging from a rope and trying to access a computer.]({{ site.baseurl }}/images/stealing-passwords.jpg)

Does that seem a little far-fetched? I agree. How about another example?

Once again, imagine you are working on your MacBook Pro in a coffee shop and using Screen Sharing.app to connect to your home Mac Studio. But this time, don't imagine a perfectly timed break-in by a tech-savvy criminal, instead imagine you have an abusive and controlling partner that lives in your house. Does that change the way you feel about this situation?

It certainly changed the way I thought about it.
## Reporting to Apple
I tested this situation multiple ways to ensure I wasn't doing something weird. Was my Mac unintentionally unlocking because of my Apple Watch? Nope. Maybe there was some sort of proximity effect due to both Macs being in the same room? Nope. Was there some sort of time-based component that allowed this to happen? Not that I could identify!

Once I felt confident that this wasn't some fluke, I submitted a case to Apple's Product Security team. Almost immediately, they replied with that old refrain so familiar to security researchers: "working as intended".
![A screenshot from an Apple Security report that plainly states "This is expected behavior."]({{ site.baseurl }}/images/Pasted%20image%2020250819184011.png)

However, Apple Security also asked me for a video demonstrating the issue. I promptly replied with a video and felt excited they hadn't completely shut me down. I hoped my video would better communicate the issue.

We went back and forth for a couple weeks, but the conversation went nowhere. After a few more repetitions of "working as intended", I informed Apple I would be posting a blog about this issue. They went silent for a few weeks and then came back with yet another "working as intended"... but with a little extra spice this time:
> We would point users who would need additional functionality to use the Remote Management service or the Apple Remote Desktop app.

Translation:
>If a remote user wants to prevent an attacker with physical access to their home computer from gaining access to their interactive session without any authentication, they should either pay to use Apple's Remote Management services or pay for Apple Remote Desktop.

Both of these solutions would cost a person substantial amounts of money just to gain some fairly basic functionality that Microsoft's RDP has provided for free for quite some time.

I totally understand Apple is in the business of making money, but this seems to fly directly in the face of the "protect the user" ethos they've demonstrated in so many other occasions.

Since they won't fix this, I'm releasing this info to the public. I tried, I promise!
>To reiterate: following standard responsible disclosure protocol, my concern was initially reported to Apple Security on May 7, 2025, but they deemed it "expected behavior." On May 22, 2025, I informed Apple Security of my intent to disclose this issue publicly.

## How To Replicate
### What is required to reproduce the issue?
- Two Macs using Apple Silicon and running macOS Sonoma or newer.
	- Mac 1: used from a remote location to control Mac 2. For example: your work Mac.
	- Mac 2: controlled from Mac 1. For example: your home Mac.
- Network connectivity between the Macs.

### Steps to reproduce
1. Open Screen Sharing.app on Mac 1.
2. At the top right of the "All Connections" window, click the + button to start a new Screen Sharing session.
3. In the "Connect To:" field of the "Screen Sharing" window, enter the hostname, fully-qualified domain name, or IP of Mac 2 and click Connect.
4. Fill in the "User Name:" and "Password:" with the credentials associated with a user of Mac 2, then click the "Sign In" button.
5. In the next window, select "High Performance" and click the "Continue" button.
6. On Mac 2, physically press the Escape key.

### Expected results
The Screen Sharing connection on Mac 1 is stopped, and the physical user in front of Mac 2 is forced to authenticate via password/Touch ID/Apple Watch.

### Actual results
The Screen Sharing connection on Mac 1 is stopped, and the physical user in front of Mac 2 takes control of the session **without authenticating.**

## Proposed Solution
I see a couple possible solutions to this issue immediately, but I'm sure there are other better options:
1. Force authentication to end a remotely controlled Screen Sharing.app session.
	- If the local user authenticates as the same user who is remotely controlling the computer, the local user would get access to the interactive session.
	- If the local user authenticates as a different user from the one remotely controlling the computer, the remote user would be prompted to allow/deny the request.
2. Default to the previous default shared view but provide an option to enable the privacy mode/screen blanking (also called 'screen curtaining' in other remote control products.) When activating privacy mode, Screen Sharing.app should inform the remote user that their session can be terminated at any time by a local user.

Unfortunately, I don't have the power to make these changes. And frankly, I find Apple's suggestion to pay a minimum of $80 for seemingly basic functionality rather appalling.

So, until something changes:
1. [Consider macOS Screen Sharing.app harmful.](https://en.wikipedia.org/wiki/Considered_harmful)
2. Do not use Screen Sharing.app unless you can physically secure your Mac.
3. Consider other remote access solutions that respect your privacy.

If you've made it all the way here because I got something wrong, please let me know! You can contact me here: [https://jakehildreth.com](https://jakehildreth.com).