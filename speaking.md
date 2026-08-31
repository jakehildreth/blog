---
layout: page
title: speaking
permalink: /speaking/
---
I like sharing knowledge. I'll be doing so in the following public arenas in the coming months:

## Upcoming Events
### HIP (Hybrid Identity Protection) Conf
* **When:** September 8-10
* **Where:** Nashville, TN
* **Site:** [hipconf.com](https://hipconf.com)
* **Talk Title:** Attackers Aren’t Wizards: Turning Red Team Lore into Real Controls
* **Co-presenter:** [Nick Vailensi](https://www.linkedin.com/in/nicholas-valiensi-2868278b/)
* **Abstract:**

	Security culture often romanticizes the “offensive mindset,” leading teams to copy red-team tricks without understanding what those signals really mean. Both red and blue teams routinely adopt patterns like querying for adminCount=1 or chasing Kerberoasting as a “cool party trick,” while missing the underlying design flaws—weak service account practices, brittle crypto choices, or systemic delegation issues—that make these attacks so reliable.
	
	This talk reframes offense as the ability to model realistic attackers, map their paths through your environment, and tie those paths to concrete controls and monitoring. Nick and Jake will use familiar techniques—password spraying, LSASS dumping, constrained/unconstrained delegation checks—as case studies in how shallow models drive bad prioritization, hero worship, and cargo-cult defenses. You’ll walk away with a more grounded attacker model and practical ideas for reshaping security culture so attackers stop being treated like wizards and their tactics start being treated like engineering signals to be designed against.

### Wild West Hackin' Fest Deadwood
* **When:** October 8-9, 2026
* **Where:** Deadwood, SD
* **Site:** [hipconf.com](https://hipconf.com)
* **Talk Title:** The Goat, The ESCalator, and The Locksmith: A Three-Act AD CS Education
* **Abstract:**

    Active Directory Certificate Services is everywhere, it's almost always misconfigured, and most organizations have no idea how bad it really is. In this talk, we'll walk through the entire AD CS security lifecycle — from building a vulnerable lab, to exploiting it, to fixing everything — using three open-source PowerShell tools purpose-built for the job.
    
    Act I: The Goat. We start by deploying a deliberately vulnerable AD CS environment using ADCSGoat. In minutes, we'll stand up a lab packed with real-world misconfigurations — ESC1 through ESC11 — that mirror what you'd find in production environments everywhere. No manual setup, no guesswork. Just Install-ADCSGoat and you've got a playground full of terrible decisions.
    
    Act II: The ESCalator. With our lab in place, we turn attacker. ESCalator identifies exploitable AD CS issue combinations that aren't always obvious on their own — the kind of chained misconfigurations that quietly hand over the keys to your forest. We'll walk through how these escalation paths work and why traditional template-by-template reviews miss them.
    
    Act III: The Locksmith. Now we fix it. Locksmith 2 scans the environment for ESC1 through ESC16 vulnerabilities, generates targeted PowerShell remediation scripts, and even provides revert scripts so you can undo changes if something breaks. We'll demo the interactive TUI and show how a defender can go from "we have a problem" to "we had a problem" in a single sitting.
    
    You'll leave with three tools you can install today, a lab you can practice in tonight, and the confidence to audit and remediate AD CS in your own environment tomorrow.

## Past Events
### PSConfEU
* **When:** June 1-4, 2026
* **Where:** Wiesbaden, Hesse, Germany
* **Site:** [psconf.eu](https://psconf.eu)
* **Talk #1 Title:** Securing PowerShell from the Ground Up 
* **Talk #1 Co-presenter:** [Andrew Pla](https://www.linkedin.com/in/andrewplatech/)
* **Talk #1 Abstract:**

    PowerShell shows up in a lot of security conversations.
    
    Sometimes as a powerful admin tool.
    Sometimes as something attackers abuse.
    And sometimes as the thing someone wants to disable entirely.
    
    In this talk, we’ll take a step back and look at how PowerShell actually fits into modern Windows environments.
    
    We’ll walk through common abuse patterns and the security features and tools you should know about, what they really do, and where they can help.
    
    You should leave this talk feeling confident and empowered about the landscape around securing PowerShell.

* **Talk #2 Title:** Watch Your Step! Building Long-Running Scripts That Don't Trip Over Themselves
* **Talk #2 Abstract:** 
    We've all been there. It's 11pm, you're running a 45-minute deployment script, and it fails at step 37 of 42. Cool. Cool cool cool. Now you get to start over. Or worse, you're not sure where it failed, so you spend 20 minutes poking around before you dare re-run anything.
    
    Long-running automation is fragile. Networks drop. Systems reboot. Someone presses Ctrl+C. Your toddler walks in and demands breakfast. Reality happens.
    
    I got tired of this, so I built Stepper: a small PowerShell module that lets you break scripts into discrete steps that automatically save their progress. When something goes wrong (or life happens), just run it again. It picks up where it left off.
    
    It's basically a really simple PowerShell Workflow that actually works in PS7+!
    
    In this session, I'll show you how to structure scripts as resumable steps, persist state across interruptions, and build configuration-driven automation that doesn't make you want to mass-delete your repo. We'll live-code an example, kill it mid-run on purpose, and watch it recover like nothing happened.
    
    You don't have to use Stepper to get something out of this talk. The patterns apply whether you're using my module or rolling your own. If you build deployments, migrations, health checks, or any multi-step automation, you'll leave with ideas you can use immediately. Stop restarting from scratch and start building scripts that remember where they were.

### PNWPSUG
* **When:** March 11, 2026 @ 9p ET
* **Where:** [https://www.meetup.com/pacific-powershell-user-group/](https://www.meetup.com/pacific-powershell-user-group/)
* **Talk Title:** Overcoming Certutil Challenges in PowerShell using Crescendo
* **Abstract:**
  
	In this talk, I discussed how I used the Crescendo project to wrap `certutil.exe` to make it quite a bit more PowerShell-friendly.

### Thursday Defensive
* **When:** February 5, 2026 @ 1:30p ET.
* **Where:** [www.thursdef.com](https://www.thursdef.com)
* **Talk Title:** AD CS and Locksmith 2!
* **Abstract:** 

    I'm going to talk about the AD CS security landscape and give a quick demo of what I've built with Locksmith 2. (More to come.)

### PowerShell Wednesday
* **When:** January 21, 2026 @ 1:30p ET.
* **Where:** [www.youtube.com/@pdq/streams](https://www.youtube.com/@pdq/streams)
* **Talk Title:** From One-Liners to (Almost) Full-Fledged Applications
* **Abstract:**

    In this talk, I'll trace the evolution of Locksmith from a few lines of demo code written for my first conference talk in 2022 to a full-fledged open-source tool. We'll walk through the original proof-of-concept snippets, the messy single-script version that followed, the refactoring into a proper PowerShell module, and how community feature requests and pull requests shaped the project in unexpected ways. I'll wrap up with a live demo of Locksmith 2 and share practical lessons about code architecture, open-source maintenance, and the reality of evolving a side project into something people actually use.

### CodeMash
* **When:** January 13-16, 2026. My talk is *currently* at 2:45p ET on January 15.
* **Where:** Kalahari Resort, Sandusky, OH
* **Site:** [codemash.org](https://codemash.org)
* **Talk Title:** PKI Unlocked: A No-Math Primer for Builders
* **Abstract:**

    Public Key Infrastructure (PKI) has a reputation for being complicated, but it doesn’t have to be. In this talk, we'll walk together through core cryptography concepts step by step. We’ll start with symmetric encryption and shared keys, then move into asymmetric encryption, hashing, signing, and certificates. From there, we’ll connect the pieces and show how they come together in an actual PKI. Each concept builds on the last to you a clear, practical understanding of how PKI works and how to spot its components in the wild. No math, no crypto proofs, just the essentials developers need.

### Anti-Cast Training
- **When:** November 12, 2025
- **Where:** [Anti-Cast](antisyphontraining.com)
- **Talk Title:** PKI Foundations for Security Pros w/ Jake Hildreth
- **Abstract:**

    Do terms like hashing, signing, and certificates feel more confusing than clear?

    Public Key Infrastructure (PKI) has a reputation for being complicated, but it doesn’t have to be.

    Join us for a free one-hour training session with Jake Hildreth, Principal Security Consultant, on PKI Foundations for Security Professionals.

    He’ll teach core cryptography step by step—from symmetric encryption and shared keys to asymmetric encryption, hashing, signing, and certificates—then connect it all in a working PKI.

### Queen City Con
* **When:** November 7, 2025
* **Where:** Hyatt Regency, Downtown Cincinnati, OH
* **Site:** [queencitycon.org](https://queencitycon.org)
* **Talk Title:** Making $ with COMPUTER$
* **Co-presenter:** [John Askew](https://www.linkedin.com/in/sk3w/)
* **Abstract:**

    When Active Directory (AD) was initially released, the designers thought it would be a good idea to allow any user to add their computer to a domain. 25 years ago, this sort of made sense: computer accounts were difficult to abuse, and users were the focus of security concerns. But in modern environments, if you can create computer accounts in Active Directory, you can probably take over the domain. In many environments, any authenticated user can do just that.

    In this talk, we’ll walk through a bunch of ways to abuse that capability: Resource-Based Constrained Delegation attacks, AD CS shenanigans, GPO and ACL abuse, SPN-in-the-middle attacks, weird stuff with Domain Computers, and a few other surprises. We’ll dig into how it works, why it’s possible, and what you can do about it. You’ll leave knowing exactly how attackers turn “net computer /add” into Domain Admin. But more importantly, you'll learn how to properly delegate this dangerous right!

### HIP (Hybrid Identity Protection) Conf
- **When:** October 7-9, 2025
- **Where:** The Charleston Place, Charleston, SC
- **Site:** [hipconf.com](https://hipconf.com)
- **Talk Title:** End the ESCape Clause!
- **Abstract:**

    Explore a critical yet often overlooked threat: how seemingly low- or medium-severity AD CS misconfigurations, known as ESCs, can combine to compromise an entire Active Directory forest. This session, based on original research and real-world assessments, demonstrates three distinct ESC chains that escalate typical user access to Domain or Enterprise Admin. Learn why defenders often miss these risks when analyzing AD CS configurations in isolation and discover ESCalator, a PowerShell tool that surfaces escalation paths by linking multiple misconfigurations. Gain actionable insights to detect and mitigate these threats before attackers exploit them.

### PancakesCon 6
- **When:** September 21, 2025
- **Where:** [pancakescon.com](https://pancakescon.com)
- **Talk Title:** PKI and Powerlifting!
- **Abstract:**

    In this talk, I will provide an no-math primer on basic PKI terms. We'll start with simple concepts like symmetric encryption and shared keys all the way up to asymmetric encryption, hashing, signing, certificates, until we end up with discussion about Public Key Infrastructure. Much like each PKI term builds on the previous terms, I'll also dicusss how you can get started in Powerlifting and build your strength!

### Blue Team Con
- **When:** September 6-7, 2025
- **Where:** Fairmont Chicago, Millenium Park, Chicago, IL
- **Site:** [blueteamcon.com](https://blueteamcon.com)
- **Talk Title:** Can opposites attract? Domain admins meet red tenant.
- **Co-presenter:** [Eric Woodruff](https://ericonidentity.com)
- **Abstract:**

    A few years ago, Microsoft deprecated the Enhanced Security Admin Environment (aka ESAE aka red forest) model and replaced it with their Rapid Modernization Plan (RAMP). Where ESAE was focused solely on legacy Active Directory (AD), RAMP is built for protecting privileged users in both AD and Entra ID. However, all is far from perfect in this new model, and the focus is heavily slanted towards protecting the cloud.

    Over the past few years, there has been talk about “red tenants”, and a few products have been released that use a red tenant approach to protect a Microsoft cloud estate with a privileged Entra tenant.

    But why should the cloud have all the fun stuff? What if we took the red tenant model and used it to protect AD?

    In this session we explore the design of an Entra tenant that has one sole purpose – protecting Tier 0 resources in Active Directory. Sound wild? We think so. But if we break ALL the rules along the way, we might end up in a place where our attack surface is reduced, our AD authentication methods are strong, and Entra might become the go to replacement for ESAE.

    Join us as we explore the architecture and what it takes to roll out the red tenant for all your AD Admins!