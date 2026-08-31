---
title: Using Crescendo to Tame certutil.exe
creation_date: 2025-05-10
modified_date: 2026-08-30
tags: [powershell, adcs]
description: "certutil.exe is good enough, but Crescendo can wrap it into something actually PowerShell-friendly."
---
![]({{ site.baseurl }}/images/gold-lights-shining-illustration-vector.jpg)In the beginning of Active Directory Certificate Services (AD CS), there was `certutil.exe`, and it was good... enough.

Then the [Shellfather](https://www.linkedin.com/in/jeffreysnover/) proclaimed "let there be Verb-Noun syntax and rich objects!", and PowerShell was wrought unto this Earth.

Over time, the new ways supplanted the old ways, but `certutil.exe` remained evermore. Its arcane tongue continued to vomit mostly-inscrutable barely-structured text upon the command line.

Many attempts were made to tame the hideous beast. The [ADCSAdministration](https://learn.microsoft.com/en-us/powershell/module/adcsadministration/) & [PSPKI](https://github.com/PKISolutions/PSPKI) modules were born, and PSPKI was very good. ADCSAdministration is... *fine...* I guess?

\</silly talk>

## Locksmith is (not quite) dead. Long live Locksmith!
I've been thinking about [Locksmith 2](https://github.com/jakehildreth/Locksmith2) (LS2) for a while. Literal years.

Ever since [Evotec](https://github.com/EvotecIT) converted the original `Invoke-Locksmith.ps1` [script into a module](https://jakehildreth.github.io/blog/2023/07/04/What-Happens-When-a-Real-Developer-Takes-an-Interest-in-Your-Open.html) in July 2023, the core Locksmith team and I have had big dreams about new and interesting ways to help overworked admins easily improve the security their AD CS installations. 

More remediation guidance! Better output! Better educational material!

But Locksmith in its current state is a mess. Adding new detections takes way longer than it should because everything is scattered among a zillion different files. Adding new features is a pain because nothing is really documented. It's usable and mostly workable, but it's not fun. 😬
![]({{ site.baseurl }}/images/0ecd79ca-713e-46f7-a997-ca3097f04a42.jpeg.avif)

So, in the interest of improving the lives of admins AND contributors, I determined I'd rather start with a fresh codebase instead of continuing to Frankenstein stuff together. And thus, LS2 truly began. We even have a [product requirement document](https://github.com/gilmourltd/product/blob/main/Product%20Requirements/Locksmith%202/PRD.md) and a [roadmap](https://github.com/gilmourltd/product/blob/main/Product%20Requirements/Locksmith%202/Roadmap.md) and stuff!

Work began in earnest a little before the end of 2024. Q1 2025 was spent doing research and planning. Q2 2025 is currently dedicated to building out all the helper functionality needed to make LS2 easier to develop. This includes identifying and cataloging ESC "combination" attacks, creating a development lab defined in code, and coding a lab snapshot tool to pull all necessary data for use in tests. 

But one of the biggest prereqs for LS2 is a PowerShell wrapper for `certutil.exe`.  

## Certutil is dead. Long live Certutil!
As mentioned above, `certutil.exe` is a way to interact with AD CS. It's a swiss army knife of functionality with an absolutely wild array of use cases. Certificate issuance history, Certification Authority (CA) configuration, access controls (ACEs) on certificate templates, Enrollment Agent Rights, and a whole slew of other stuff. Most of its most powerful functionality is hidden behind a mostly unintelligble combination of switches and registry shortcuts.

Seriously, what is this?
![]({{ site.baseurl }}/images/Pasted%20image%2020250518070904.png)
BTW: This is only about 20% of the full output of the `/?` switch. Each of these switches has its own help too. And let's not get into the unlisted options only visible with the `-uSAGE` switch or the completely undocumented features! Working with `certutil.exe` does sometimes feel like working with another language.

The output from `certutil.exe` is equally messy:
![]({{ site.baseurl }}/images/Pasted%20image%2020250518071835.png)
Not only is it messy, it's not objects. Coming from a bash/batch scripting background, I didn't really understand what objects were until late 2021. Then one day, I got it.

Now I want only want to work with objects. Give me objects. I need more objects.

So, `certutil.exe` is a pain to work with and doesn't output objects. Why not use PSPKI instead? It's easy to use, actively maintained, and has wonderful help.

Three reasons:
1. I want to learn more about `certutil.exe`'s functionality, and coding is how I learn best.
2. `certutil.exe` exists on every Windows computer by default.
3. *I'm stubborn and don't like having dependencies on the tooling of others.*

I've successfully parsed `certutil.exe` output in multiple ways in Locksmith, but every time I do it, I hate myself a little more. I *know* there's a better way...

## Enter Crescendo
From the [README](https://github.com/powershell/crescendo):
> Crescendo is a development accelerator enabling you to rapidly build PowerShell cmdlets that leverage existing command-line tools. Crescendo amplifies the command-line experience of the original tool to include object output for the PowerShell pipeline, privilege elevation, and integrated help information. A Crescendo module replaces cumbersome command-line tools with PowerShell cmdlets that are easier to use in automation and packaged to share with team members.

I first heard about Crescendo from [Jason Helmick](https://www.linkedin.com/in/jason-helmick-1880b812/)'s appearance on [RunAsRadio](https://runasradio.com/Shows/Show/760). I was pretty early in my PowerShell journey at the time. As mentioned earlier, I didn't really understand what objects were, so I didn't understand why I wanted them. But the project sounded cool, so I kept it in the back of my mind.

Then, while figuring out how to detect [ESC11](https://blog.compass-security.com/2022/11/relaying-to-ad-certificate-services-over-rpc/) and swearing to myself as I poked around with stupid unstructured text, Crescendo popped into my head. Instead of figuring out how to parse this output every time, I could use Crescendo to create a wrapper that put the required switches in the proper order and spit out rich objects that could be easily consumed by other pieces of code.

Additionally, Crescendo is configured using JSON. I am JSON-averse, so a little exposure therapy sounded useful.
![]({{ site.baseurl }}/images/Pasted%20image%2020250518080045.png)
*What IS this?!?!*
## Finally: PSCertutil!
In January of this year, I was having a rough go of it. I was searching for a new job, and it was the darkest days of winter. Learning new stuff lifts my spirits, so I decided it was time to build a new thing!

I read [Sean Wheeler's blog series about Crescendo](https://devblogs.microsoft.com/powershell-community/tag/crescendo/). I watched a couple talks from Stephen Valdinger aka steviecoaster ([this one is cool](https://www.youtube.com/watch?v=JBFhptwwYuU&pp=ygUbY3Jlc2NlbmRvIHN0ZXBoZW4gdmFsZGluZ2Vy)) about the stuff I needed to know. And then I dove in. Stevie was also gracious enough to help me get started in January. 

I built! I felt better! Then [I got a new job](https://jakehildreth.github.io/blog/2025/03/08/New-Job-New-MVP.html) and compltely dropped the project. lol

But in the last few weeks, I've picked it back up. In the intervening months, I'd learned a lot more about regex in that time which made parsing the `certutil.exe` vomit MUCH easier this time around.

After a few weekends of work, I finally got everything working in PS7! I ran into a small hurdle getting some functions working in PS5.1, but Stevie helped me out there too.

Here it is: [https://github.com/jakehildreth/PSCertutil](https://github.com/jakehildreth/PSCertutil)

Some notes: 
- I've only added the features *I need* to get going in Locksmith 2.
- There is no plan to recreate the entire feature set of `certutil.exe`. I don't hate myself that much.
- There's almost zero error handling. Use at your own risk.

But for my own use, it's more than enough! I mean, look at the output before:
![]({{ site.baseurl }}/images/Pasted%20image%2020250518080835.png)
And after:
![]({{ site.baseurl }}/images/Pasted%20image%2020250518081012.png)
Even if you're not a PowerSheller, I bet you see an improvement!

Anyway, my daughter just woke up, so it's time to make breakfast. If you made it this far, please try out [PSCertutil](https://github.com/jakehildreth/PSCertutil) and let me know what you think. All my contact info is at [http://jakehildreth.com](http://jakehildreth.com). 

Until next time, friends!