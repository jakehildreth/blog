---
title: Virtualizing Windows Server 2025 on Apple Silicon
creation_date: June 24, 2024
modified_date: 2026-02-15
tags: [homelab, macos]
description: "Hi, I'm Jake, and I'm a Mac user. Getting Windows Server 2025 virtualized on Apple Silicon for AD security work."
---
Hi everyone. My name is Jake... and I'm a Mac user. 

The (not very) big secret is out.

In my day job, I lead a [service](https://www.trimarcsecurity.com/ad-security-assessment) focused on assessing the security of one of Microsoft's most used technologies, Active Directory [AD]. But for 18 years, I've used a MacBook as my daily driver. How did I get here?

(If you don't care about why I'm a Mac user, skip to the [**How To**](#how-to) section.)

## Some History

I've always been a user of multiple operating systems. I had experience with C64, Apple IIe, DOS, and Mac OS before I ever touched a Windows device.

I started seriously learning computers with Windows 95, but from the late 90s onward, I've always had a device (or a partition on a device) dedicated to running Linux.

Even now, my Mattermost server runs on Ubuntu, and I have a Kali VM I spin up when I need to do some "hacking" aka running Python. I like learning different ways to do the same task to find the best tool for a job. Regularly using multiple OSes makes that possible.

### All Aboard the Apple Train?

In 2006, Apple switched to Intel chips for the Mac/OS X. I knew I **needed** to get something in the Mac line, but I was too poor (aka bad with money) at the time to spend nearly $2000 on technology I had no clue how to properly use. To be completely honest, I just thought the black MacBook looked super sexy.

Thankfully, I was able to convince my boss at the time to refresh my corporate laptop **two years** early and get a MacBook (the black one! 😍). I sold him with lines like "it can run software from Mac, Linux, AND Windows ecosystems" and "if everything else in the forest gets infected with a virus, I'll still be able to manage the network." It helped that he was a guy who liked experimenting with new tech.

After receiving the MacBook, I had a month-long period best described as my WTF Era. Some Apple-y things made sense immediately, but other tasks were just so foreign. I remember being flabbergasted by burning a CD. I regularly visited a few sites that gave great guidance on transitioning from Windows to OS X, but the absolute best thing I did was change my approach to computing.

My MacBook wasn't a thing to be deciphered but instead a tool to be used. And like the best tools, its most basic functions should be useable by non-experts with little-to-no training. I started approaching the Mac as someone with little computer training would, and things just started clicking.

### I Joined The Cult

OS X on Intel was **fun**. Most Unix and Linux tools ran with little modification. Basic Windows utilities could run in Wine. And if I needed to run something more complex, Boot Camp gave me access to a full Windows installation.

I figured out a great workflow for doing most of my productivity work, network administration, and VMware administration from my Mac while running a Windows Virtual Machine (VM) in Parallels to handle Windows-specific tasks (Outlook and Remote Server Administration Tools [RSAT], basically). The specifics of this setup changed over time but the basic shape stayed the same throughout.

Eventually, I went in hard on the Apple ecosystem. Almost all technology in my house is Apple brand. I love that it (usually) Just Works. I love that I can share things with my family easily. I love that the Apple operating systems reveal their features over time and can be heavily customized, but the basic functions serve most people just fine.

### A New Era

Fast forward to 2020. Apple announced they are transitioning Macs and macOS to use Apple Silicon. Apple had been producing their own mobile chips for years, and this transition promised tighter coupling of software and hardware resulting in better performance and battery life. I was jazzed.

Yet again, I was able to convince my boss to let me upgrade my corporate laptop early so I could get my hands on a new MacBook Pro with an M1 chip. I received it in mid-January 2020 and immediately fell in love. It was super snappy and so damn powerful. I remember loading ~14 4K videos without even a tiny hiccup. I never got the cooling fan to spin up during normal use. And much like the transition to Intel chips, Apple made the transition to their silicon super smooth. Rosetta 2 is a beast.

### Virtualization Challenges

Despite the obvious improvements presented by Apple Silicon, the new chip presented a serious problem for me: I regularly ran Windows in VMs on my older MacBooks for testing and goofing around. Virtualizing x86_64 Windows was not possible on Apple Silicon. Windows 10 on ARM was a thing, but I already had a couple of different ways to do Windows-centric work and various places to run x86 VMs, so I didn't go down that rabbit hole too far.

More importantly, I had just started working towards an associate's degree and beginning my search for jobs in security. I just didn't have free time to play with unsupported stuff.

Eventually, Windows-on-ARM became better supported on Apple Silicon. VMware and Parallels both released versions of their workstation software that could run Win 10 and Win 11. My virtualization platform of choice, UTM, also started supporting Windows-on-ARM. I tried all of the options, and they all ran **great**!

But I wanted to test AD, and you can't stand up a forest without Windows Server, and Server-on-ARM wasn't really a thing. Until recently, that is!

### Virtualization Breakthrough

Recently, I randomly googled "server 2025 arm iso" and came across a few Reddit threads talking about the performance and support for Server 2025 on ARM... this looked promising.

I grabbed some ISO packages from [uupdump.net](https://uupdump.net) and spent a few hours building ISOs on my Mac. After building, I would attempt to use the ISOs in VMware Fusion and UTM, but I kept getting stuck in boot loops. Eventually, I realized it was way WAY past my bedtime and shut down for the night.

The next morning, I re-read some of the threads from the night before and noticed my mistake. Apparently, you need to build the installation ISO on Windows. I'd been building my ISOs on macOS. As soon as I built the installation media on Windows, Server 2025 booted and installed!

After the initial setup, I tried the real test: installing the AD Directory Services role and creating a forest. IT WORKED! Here's the logon screen for ARM2025DC.ad.dotdot.horse.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-76]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-76.png)

I mentioned my success to Jim Sykora who immediately upped the ante and asked me if it was possible to join ARM-based DCs to a forest containing only x86_64-based DCs. I wasn't sure, so I tried creating a new child domain in a test forest we share (BlueTuxedo.DanglingSPNs.lol). 

Would it work? Short answer, YUP! 

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-77]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-77.png)

So now, I have a single-domain ARM-only test forest that lives completely on my MacBook Air M1 (ad.dotdot.horse) and a mixed x86/ARM multi-domain test forest (BlueTuxedo.DanglingSPNs.lol) partially hosted in Jim's house. The options should allow for lots of interesting testing. 

I'm sorry for the long-winded journey, but if recipe sites have taught me anything, it's that recipes need long-winded journeys for introductions.

All right, let's get cooking.

## How To

This is a distilled version of what ended up working *for me*. There are other approaches you could take at certain points, and I'm sure each choice has its benefits. I do not claim this is the best or most efficient method. But I had no interest in things like "weighing my options" or "making choices"; this is the laziest method possible.

### Install UTM

[https://apps.apple.com/us/app/utm-virtual-machines/id1538878817](https://apps.apple.com/us/app/utm-virtual-machines/id1538878817)

UTM is a GUI front-end for QEMU. It makes the process of booting and running a VM pretty easy. And because it uses QEMU, you can emulate a bunch of other processor architectures (at a speed cost). But hey, if you wanna emulate Win 3.11, you can!

I think there's a monetary cost for the prebuilt version of UTM  available in the macOS App Store, but I like all the benefits that come from that distribution method. As I said, this is the laziest method possible, and sometimes laziness costs a few bucks.

### Install CrystalFetch

[https://apps.apple.com/us/app/crystalfetch-iso-downloader/id6454431289?mt=12](https://apps.apple.com/us/app/crystalfetch-iso-downloader/id6454431289?mt=12)

CrystalFetch is used by UTM to create ISOs from information found on uupdump.net which itself pulls UUP files from Microsoft's official UUP repositories.

### Install Windows 11-on-ARM

After installing UTM, you need to stand up a Windows 11 VM. UTM makes it easy.

First, click the **+** button to start the installation process.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-78]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-78.png)

Next, click the **Virtualize** button.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-79]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-79.png)

Click the **Windows** button.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-80]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-80.png)

Click the **Fetch latest Windows installer...** link. This opens CrystalFetch.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-81]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-81.png)

Select **Windows 11** and click the **Download...** button. When CrystalFetch is done generating the ISO, you will be prompted to save it somewhere. Save it somewhere you'll remember because you'll need it in the next step.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-82]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-82.png)

Under "Boot ISO Image" click the **Browse...** button and select the ISO you just saved. You already forgot where you saved it, didn't you?
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-83]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-83.png)

On the "Hardware", "Storage", and "Shared Directory" pages, feel free to modify as you wish then click the **Continue** button. I modified nothing because I am using the laziest method possible.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-84]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-84.png)

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-85]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-85.png)

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-86]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-86.png)

On the Summary page, you should set a "Name" and then click **Save**. I didn't set a Name because...
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-87]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-87.png)

That's it! You have a Windows 11-on-ARM VM. Click any of the play buttons to start up the installation and configuration process.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-88]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-88.png)

Note: I am not detailing the installation process for Windows 11. It's mostly easy.

### Create Server 2025 Installation Media

Log into your Windows 11 VM.

Open Edge.

Head to uupdump.net and search for "server arm64" to get a list of available 2025 ARM ISOs. (There might be a way to do this from the various on-screen menus, but yet again, I'm going for the laziest options possible.)
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-89]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-89.png)

When you search, you'll be presented with a list of results that looks something like this:
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-90]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-90.png)

The results are a mix of installation media and updates. Dig through until you find installation media that suits your level of danger: release or pre-release. I like to live dangerously, so I selected " Windows Server Insider Preview 26212.5000 (ge_prerelease) arm64": [https://uupdump.net/selectlang.php?id=cb985455-1f1d-43fd-9208-3bd74477d90e](https://uupdump.net/selectlang.php?id=cb985455-1f1d-43fd-9208-3bd74477d90e)

Click the link!

Now we're into a section that allows you to lightly configure your installation media. First, select your language and click **Next**.

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-91]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-91.png)

Then select the editions you'd like to work with. I wanted a small installer, and I am not super-1337, so I unchecked everything except Windows Server Standard. When you're done making your selection, click **Next**.

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-92]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-92.png)

My laziness impels me to let other smarter people do things on my behalf, so I am choosing to download an installation package that compiles the downloaded UUP files and converts them into a single ISO for later use. If you know how to compile UUPs into an ISO, choose that option instead! Hopefully, this is the most difficult choice you need to make today.

Whatever you decide, you need to click **Create download package** when you are done.

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-93]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-93.png)

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-94]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-94.png)

When the download package is complete (it's very small), click **Open file**  to open the compressed package.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-95]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-95.png)

While viewing the contents of the download package file, click the 3 dots and choose **Extract all**. 
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-96]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-96.png)

Extract the package contents to a location you will remember. I am lazy, so I accepted the defaults.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-97]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-97.png)

The extracted files will be displayed in a folder. Right-click uup_download_windows.cmd and select **Run as administrator**.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-98]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-98.png)

You will likely be presented with a scary prompt about Windows protecting you from yourself. Click **More info** and **Run anyway**.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-99]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-99.png)

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-100]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-100.png)

A Windows Terminal window will pop up and ask you if you want to run an unsigned script. Enter **R** and press Enter.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-101]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-101.png)

You will then begin seeing files download and stuff happening. Just relax. Depending on the options you configured, you may be downloading anywhere from 2-13GB of UUP files.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-102]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-102.png)

If you get hit with an error that you downloaded no files, try the process again. If you get the same error a second time, head back to uupdump.net and pick a different installation package.

Once the files are downloaded, the installer/converter (aria2) will compile the downloaded UUP files into a bootable ISO. If everything worked correctly, you will see:
```
Finished
Press 0 or q to quit
```
Press 0 or q.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-103]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-103.png)

You should now see an ISO file!
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-104]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-104.png)

### Transferring the ISO
So now you have an ISO file... but it's on the Windows 11 VM's storage. You need it on your Mac's storage so you can use it for the next section. Thankfully, UTM allows you to share folders on the host machine to make them available in the guest VM.

Unfortunately, I cannot seem to get this file transfer process working consistently using UTM's shared directory tools, so this step is currently left as an exercise for the reader. I uploaded my ISO to iCloud temporarily and then downloaded it to my Mac.

### Install Server 2025-on-ARM

This section is pretty much a duplicate of the "Install Windows 11-on-ARM" section above, but I'm including it for completeness.

First, click the **+** button to start the installation process.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-105]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-105.png)

Next, click the **Virtualize** button.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-106]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-106.png)

Click the **Windows** button.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-107]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-107.png)

This is where the process diverges slightly from the Windows 11 installation. Instead of using UTM/CrystalFetch to "Fetch latest Windows installer...", we're going to go directly to "Boot ISO Image", click the **Browse... **button, and select the Server ISO you just transferred from Win 11 to macOS. You forgot where you saved that one too, didn't you?
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-108]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-108.png)

On the "Hardware", "Storage", and "Shared Directory" pages, feel free to modify as you wish then click the **Continue** button. I modified nothing because I am using the laziest method possible.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-109]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-109.png)

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-110]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-110.png)

![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-111]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-111.png)

On the Summary page, you should set a "Name" and then click **Save**. I didn't set a Name because...
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-112]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-112.png)

That's it! You have a Windows Server 2025-on-ARM VM. Click any of the play buttons to start up the installation and configuration process.
![2024-06-24-Virtualizing Windows Server 2025 on Apple Silicon-113]({{ site.baseurl }}/images/2024-06-24-Virtualizing%20Windows%20Server%202025%20on%20Apple%20Silicon-113.png)

Note: I am not detailing the installation process for Windows Server 2025. It's mostly easy.

## Conclusion

Now that Server 2025 is installed, do something fun with it:
* Install AD DS + DNS/DHCP
* Run [BlueTuxedo](https://github.com/TrimarcJake/BlueTuxedo) to find out-of-the-box DNS issues you can fix to immediately improve DNS security.
* Install AD CS
* Run [Invoke-TSS.ps1](https://github.com/TrimarcJake/Locksmith/blob/main/Tests/Invoke-TSS.ps1) to screw up your AD CS!
* Run [Locksmith](https://github.com/TrimarcJake/Locksmith) to find all the issues TSS created so you can clean them up.
* Run [BadBlood](https://github.com/davidprowe/BadBlood) to create a bunch of dangerous permission delegation issues.
* Use [ADeleg](https://github.com/mtth-bfft/adeleg) + [ADeleginator](https://github.com/techspence/ADeleginator) to identify permission delegation issues.

If this guide inspires you to install Server 2025 on ARM, please reach out to me at [jake@dotdot.horse](mailto:jake@dotdot.horse) to let me know how it went. I'm always looking to improve my documentation, and I'd love to hear what cool stuff people are doing with Apple Silicon!
