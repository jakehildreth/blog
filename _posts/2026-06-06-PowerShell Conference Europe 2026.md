---
title: PowerShell Conference Europe 2026
creation_date: 2026-06-06
modified_date: 2026-06-07
---
Hello, friends!

Over the past week, I had the absolute pleasure to attend and present at PowerShell Conference Europe aka [PSConfEU](https://psconf.eu). 
## My Journey to Germany
I started my journey to the conference in the afternoon of Saturday, May 30th with arrival in Frankfurt (FRA) scheduled for 9:30a on Sunday.

About twenty minutes before landing at FRA, the pilot came on the intercom to inform us that landings were paused due to heavy storms. Forty minutes after that, the pilot informed us we were low on fuel and diverting to Munich (MUC) for refueling.

It took about an hour to fly to MUC, two hours to fuel up, then one more hour to fly back to FRA. Air conditioning was turned off for part of the time while waiting for refueling, but thankfully was restored before people started getting too anxious. In the end, my scheduled eight-hour flight ended up taking twelve hours. 😭

After landing, passport control was quite quick because we landed so late. Finding the bus to get from Terminal 3 (where I landed) to Terminal 1 (where the train station is) was more difficult than expected, but I ended up pairing up with an older American couple who was also lost. With our powers combined, we finally found the bus and traveled to the train station.

After a pleasant train ride and a short walk, I arrived at my final destination: the Dorint Pallas Wiesbaden hotel. As I walked in the lobby door, I immediately saw smiling faces of people I'd only known online, including Stephen Valdinger aka Steviecoaster. Stevie and I live 2 hours apart, but we'd never met in person until seeing each other in the hotel lobby!
## The Venue
PSConfEU is held in a different city every year, and this year was Wiesbaden, Germany. Wiesbaden is a medium-ish sized in the German state of Hesse. I didn't get to explore much of the city, but there was a nice city centre with plenty of pedestrian areas.

The conference hotel was nice but not fancy, if that makes sense. There was decent food for breakfasts and lunches, plenty of snacks and coffee, and delicious sparkling water available *everywhere.*

The largest presentation room was able to hold the entire attendance of the conference, about 300 people. It had a large central screen and several smaller screens so people in the back could see well. Unfornately, the other three presentation rooms were fairly basic affairs with low screens that made it difficult for some content to be seen from the back of the room. Thankfully, most of the speakers recognized this and made to sure to zoom and scroll so content was clearly visible.

Also, Macs *did. not. work. consistently.* More on that later. Now, on to the good stuff: the talks!
## The Content
I attended 13 different talks throughout the week. At other cons, I attend 1-2 talks per day, but this one was so full of stuff I wanted to see. I'll talk about each in the order I saw them:
### Opening Remarks - Gael Colas, Barbara Forbes, Rob Sewell
I did not get to catch much of this because I was working with Andrew Pla putting finishing touches on slides, but it was awesome to see Gael, Barbara, and Rob having a great time on stage dressed in shimmering sequins to celebrate the 10th PSConfEU. It's clear that the organizers love this conference, and you could feel it in the air.
### From ConfigMgr to Manager of Configs - Hailey Phillips
I popped in at the end of Hailey's talk just as she was transitioning from technical talk into a more human-centric discussion. She had built a bunch of technical solutions to common problems in her org, but none of them got much uptake by her coworkers until lines of communication were more open. Open communication was definitely a recurring theme throughout many of the talks I saw.
![]({{ site.baseurl }}/images/Hailey1.png)
* Abstract and slides: [https://github.com/psconfeu/2026/tree/main/hailey-phillips/from-configmgr-to-manager-of-configs](https://github.com/psconfeu/2026/tree/main/hailey-phillips/from-configmgr-to-manager-of-configs)
* Hailey's personal site: [https://www.allwayshype.com](https://www.allwayshype.com)

### Securing PowerShell From The Ground Up - Andrew Pla & Jake Hildreth
In this session, Andrew and I talked about three common ways of securing PowerShell that have proven benefits: enhanced logging, Constrained Language Mode, and disabling PowerShell 2.0 on older versions of Windows. Despite a glitchy projector that *hated* Andrew's Mac, we ended up putting on a fairly well-reviewed talk and got plenty of follow-up questions from the crowd. Andrew even put together a tool (SecurityPosturePS) to make securing stuff a little easier. 
![]({{ site.baseurl }}/images/JakeAndrew.png)
* Abstract: [https://github.com/psconfeu/2026/tree/main/andrew-pla-jake-hildreth/securing-powershell-from-the-ground-up](https://github.com/psconfeu/2026/tree/main/andrew-pla-jake-hildreth/securing-powershell-from-the-ground-up)
* Tool: [https://github.com/AndrewPla/SecurityPosturePS](https://github.com/AndrewPla/SecurityPosturePS)
* Andrew's personal site: [https://andrewpla.tech](https://andrewpla.tech)

### Argument completers, Dynamic parameters, and more: Building better PowerShell functions - Ben Reader
This talk blew my mind. I knew about basic and intermediate argument completion methods, but Ben shocked me by live coding a tool that separated argument completion logic from configuration in such an elegant manner that almost anyone could update the script and use it with little help. I especially loved that he kept harping on making things easier for the end user.
![]({{ site.baseurl }}/images/Ben.png)
* Recording: [https://youtu.be/hYWCus5qPLc?si=w6P_j2unJMLovnSS](https://youtu.be/hYWCus5qPLc?si=w6P_j2unJMLovnSS)
* Abstract: [https://github.com/psconfeu/2026/tree/main/ben-reader/argument-completers-dynamic-parameters-and-more-building-better-powershell-functions](https://github.com/psconfeu/2026/tree/main/ben-reader/argument-completers-dynamic-parameters-and-more-building-better-powershell-functions)
* Ben's personal site: [https://powers-hell.com](https://powers-hell.com)

### PowerShell…..with buttons - Stephen Valdinger & Andrew Pla
In this 90 minute session, Stevie walked Andrew through a demo of a web app built on  PowerShell Universal that Andrew could use to book guests onto the [PowerShell Podcast](https://www.pdq.com/resources/the-powershell-podcast/). It made me *really* want to get proficient with PowerShell Universal. 

* Abstract: [https://github.com/psconfeu/2026/tree/main/stephen-valdinger-andrew-pla/powershellwith-buttons](https://github.com/psconfeu/2026/tree/main/stephen-valdinger-andrew-pla/powershellwith-buttons)
* Stevie's personal site: [https://steviecoaster.dev](https://steviecoaster.dev)

### Who Am I? Applied Tokenology for PowerShellers - Evgenij Smirnov
Fellow Semperian, Evgenij Smirnov, had a packed room for his talk about tokens... no not LLM tokens. Not cryptocurrency. Not even JWTs and the like. He was talking about access tokens, those little bits of info that contain the security credentials for your login session and identifies your groups and privileges etc. I had to leave his talk about 20 minutes in, but I was around long enough to see him poke a little fun at me and Andrew's tech issues. 🤣
![]({{ site.baseurl }}/images/Evgenij.png)
* Abstract, slides, and demo materials: [https://github.com/psconfeu/2026/tree/main/evgenij-smirnov/who-am-i-applied-tokenology-for-powershellers](https://github.com/psconfeu/2026/tree/main/evgenij-smirnov/who-am-i-applied-tokenology-for-powershellers)
* Evgenij's personal site: [https://it-pro-berlin.de](https://it-pro-berlin.de)

### Level Up Your Terminal Experience - Andree Renneus
I was only able to catch the last ten minutes of Andree's talk about cool Terminal stuff, but I was super-impressed with the wide breadth of tools and toys that he showed in those last ten minutes since it was focused on one of my current special interest: terminal user interfaces. I definitely want to see the full recording of this one.
![]({{ site.baseurl }}/images/Andree1.png)
* Abstract: [https://github.com/psconfeu/2026/tree/main/andree-renneus/level-up-your-terminal-experience](https://github.com/psconfeu/2026/tree/main/andree-renneus/level-up-your-terminal-experience)
* Andree's BlueSky: [https://bsky.app/profile/trackd.x64.se](https://bsky.app/profile/trackd.x64.se)

### Watch Your Step! Building Long-Running Scripts That Don't Trip Over Themselves - Jake Hildreth
I missed pieces of Evgenij and Andree's talks because I snuck away to the hotel bar for a drink. My nerves were *so* on edge. But it turns out, I had nothing to fear. My talk flowed exactly as I'd practiced and my demos went off without a hitch. People seemed genuinely interested in [Stepper](https://jakehildreth.github.io/blog/2025/12/21/Stepper.html), asked lots of questions, and submitted multiple feature requests live!
![]({{ site.baseurl }}/images/Jake.png)
* Abstract, slides, and demo materials: [https://github.com/psconfeu/2026/tree/main/jake-hildreth/watch-your-step-building-long-running-scripts-that-dont-trip-over-themselves](https://github.com/psconfeu/2026/tree/main/jake-hildreth/watch-your-step-building-long-running-scripts-that-dont-trip-over-themselves)

### IntuneStack - a CI/CD PowerShell workflow for managing Intune policy - Hailey Phillips
I've never used it, but apparently Intune is a poor experience for use in shops with modern DevOps-style management. Everyone sees the same GUI, and "we all click together", as Hailey said multiple times in this session. IntuneStack adds a bit of CI/CD goodness to Intune by designating computer groups as dev/test/prod. When an update reaches 80% success in the dev group, it gets promoted to a test update and starts deploying to that group. Repeat for prod. Pretty neat!

* Abstract: [https://github.com/psconfeu/2026/tree/main/hailey-phillips/intunestack-a-cicd-powershell-workflow-for-managing-intune-policy](https://github.com/psconfeu/2026/tree/main/hailey-phillips/intunestack-a-cicd-powershell-workflow-for-managing-intune-policy)
* Hailey's personal site: [https://www.allwayshype.com](https://www.allwayshype.com)

### Spawn of a Shell - Handling Sub Processes - Jordan Borean
Did you know there are like 13 different ways to spawn new processes in PowerShell? And each one has its own little quirks? I didn't either, but now I do! Jordan expertly walked through the varius approaches to sub-processes with a terminal-based presentation style that was simultaenously information and demo.
![]({{ site.baseurl }}/images/Jordan.png)
* Abstract and presentation code: [https://github.com/psconfeu/2026/tree/main/jordan-borean/spawn-of-a-shell-handling-sub-processes](https://github.com/psconfeu/2026/tree/main/jordan-borean/spawn-of-a-shell-handling-sub-processes)
* Jordan's GitHub: [https://github.com/jborean93](https://github.com/jborean93)

### Microsoft Graph with PowerShell 101 - Jan-Hendrik Peters
The Graph API is a weak spot for me; I know I need to learn it. So, Jan-Hendrick's 101-level course sounded perfect. Unfortunately, I think I need more like the 100-level course with someone holding my hand the whole way. Others seemed to be enjoying the class, but I had to leave about 30 minutes in because I was so lost. I plan to follow along with the recording when its released so I can pause/rewind etc.

* Abstract and slides: [https://github.com/psconfeu/2026/tree/main/jan-hendrik-peters/microsoft-graph-with-powershell-101](https://github.com/psconfeu/2026/tree/main/jan-hendrik-peters/microsoft-graph-with-powershell-101)
* Jan-Hendrik's personal site: [https://www.janhendrikpeters.de](https://www.janhendrikpeters.de)

### VSCode everywhere: Set Up Once, Use Anywhere - Constantin Hager
*This* talk was fantastic. Constantin walked the crowd through multiple ways to set up standard development environments accessible from anywhere using Dev Containers and code-server. Standard development environments make it super easy for new developers to get onboarded to a project and to be able to write code from anywhere! This was proably the talk that most inspired me.

* Abstract and code: [https://github.com/psconfeu/2026/tree/main/constantin-hager/vscode-everywhere-set-up-once-use-anywhere](https://github.com/psconfeu/2026/tree/main/constantin-hager/vscode-everywhere-set-up-once-use-anywhere)
* Constantin's personal site: [https://the-itguy.de](https://the-itguy.de)

### Musical PowerShell - Make your scripts sound awesome! - Björn Sundling
For some reason, this talk didn't catch my eye when it was first announced, despite loving both music and coding. But in the months leading up to the con, Björn dropped a few hints about what he was planning with the other 2026 speakers. I was *so* hyped to see this that I mentioned it a few times in my own talks! Bjorn walked through the new MIDI subsystem built into Windows 11 which includes first-party PowerShell cmdlets! After showing basic "note on" and "note off" functionality, he walked through creating a queueing system, reverse engineering MIDI 2.0 packet format, and using some sort of sub-processes to create real music that stayed in time! It was the most raucous talk of the whole con.

* Abstract, slides, and code: [https://github.com/psconfeu/2026/tree/main/bjorn-sundling/musical-powershell-make-your-scripts-sound-awesome](https://github.com/psconfeu/2026/tree/main/bjorn-sundling/musical-powershell-make-your-scripts-sound-awesome)
* Björn's personal site: [https://bjompen.com/](https://bjompen.com/)

### Behind the Scenes of PwshSpectreConsole - Andree Renneus
I initially joined this session to support Andree. He was programmed against Jeffrey Snover, Sean Wheeler, and Fred Weinmann and expected to have no one in his talk. Attendance was slimmer than he'd have liked, but honestly, it might've made it better. Jordan Borean and Jakub Jareš asked tons of questions throughout the session that Andree handled with aplomb. His behind the scenes view of one of the most powerful modules in the PowerShell world really shed light on the design decisions and future plans. Can't wait to see where PwshSpectreConsole goes in the next year!
![]({{ site.baseurl }}/images/Andree2.png)
* Abstract: [https://github.com/psconfeu/2026/tree/main/andree-renneus/behind-the-scenes-of-pwshspectreconsole](https://github.com/psconfeu/2026/tree/main/andree-renneus/behind-the-scenes-of-pwshspectreconsole)
* Andree's BlueSky: [https://bsky.app/profile/trackd.x64.se](https://bsky.app/profile/trackd.x64.se)

### The PoShaKucha presentations: The Stage is yours!
From the PSConfEU site:
>Fancy some nerdy PowerShell knowledge at warp speed? PoShaKucha is a storytelling format in which a presenter shows 20 slides for 20 seconds of commentary each, it's a PowerShell flavored fork of the well-known PechaKucha format.   
>  
>This presentation style is characterized by concise, fast-paced talks. A PoShaKucha challenges speakers to distill their ideas into a concise yet impactful narrative, as it must not succeed the strict limit of 6 minutes and 40 seconds.   
>    
>Who dares to go on stage? The stage is open to any applicant, throw your hat into the ring! We can't wait to see you juggle 20 slides.

This format is *amazing.* The slides advance themselves, and the presenters have to be *very* prepared. If they spoke too fast and got ahead of the slides, and if they spoke too slowly or went into too much detail, they'd fall behind and be left talking about something no longer on-screen. All the presenters did great in their own way, and the topics varied *widely.* For example: Glenn's talk made me tear up. Who gets teary at a tech conference?!

* Finding App Permissions in the Entra Maze - Andres Bohren
* Sharing: What's in it for me!? - Glenn Sarti
* Object-Graph Tools - Ronald Bode
* 20 Lessons From the PowerShell Podcast, Whether I Learned Them or Not - Andrew Pla
* Your Graph Apps Are Over-Privileged — Let’s Fix That! - Morten Mynster
* How hard can it be to count a few XML nodes? - Manfred Wallner
* PoShaKucha hits the lock screen - Frank Lindenblatt
![]({{ site.baseurl }}/images/Glenn.png)
![]({{ site.baseurl }}/images/Morten.png)
![]({{ site.baseurl }}/images/PoshaKuChas.png)
## The Community
I've always felt completely at home in the PowerShell community online, and the in-person experience was no different. I was able to walk up to anyone and start a conversation without issue. It reminded me a lot of the vibe I get from [Blue Team Con](https://blueteamcon.com) but even more beginner-friendly. It was awesome to meet tons of people in person that I knew from online as well as a few people I did not know previously. Like any community, there are small social circles within the larger community, but unlike other communities those small social circles never felt like barriers to new friends. Most importantly, there was constant discussion about how to make the community more accessible.
![]({{ site.baseurl }}/images/IMG_1573.png)
![]({{ site.baseurl }}/images/IMG_1610.png)
![]({{ site.baseurl }}/images/IMG_1619.png)
![]({{ site.baseurl }}/images/IMG_1621.mov)
![]({{ site.baseurl }}/images/IMG_1625.png)
![]({{ site.baseurl }}/images/IMG_1652.png)
![]({{ site.baseurl }}/images/IMG_1658.png)
![]({{ site.baseurl }}/images/IMG_1660.png)
![]({{ site.baseurl }}/images/IMG_1663.png)
![]({{ site.baseurl }}/images/IMG_1670.png)
## In Conclusion
If you use PowerShell, whether personally or professionally, but you're not a member of the PowerShell community already... what are you waiting for? Join the PowerShell Discord server. Join the #powershell-scripting channel on the PDQ Discord Server. Come to an event like PSConfEU or PowerShell Summit. Visit a user group. SOMETHING. When you do, I promise you'll grow much more quickly in skillset as well as mindset.

Also, I can't thank the organizers of PSConfEU enough for putting together such an amazing event. I hope they'll have me back as a speaker next year! 🤞