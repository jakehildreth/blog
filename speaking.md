---
layout: page
title: speaking
permalink: /speaking/
---
I like sharing knowledge. I'll be doing so in the following public arenas in the coming months:
#### Queen City Con
* **When:** November 7, 2025
* **Where:** Hyatt Regency, Downtown Cincinnati, OH
* **Site:** [queencitycon.org](https://queencitycon.org)
* **Talk Title:** Making $ with COMPUTER$
* **Co-presenter:** [John Askew](https://www.linkedin.com/in/sk3w/)
* **Abstract:**

    When Active Directory (AD) was initially released, the designers thought it would be a good idea to allow any user to add their computer to a domain. 25 years ago, this sort of made sense: computer accounts were difficult to abuse, and users were the focus of security concerns. But in modern environments, if you can create computer accounts in Active Directory, you can probably take over the domain. In many environments, any authenticated user can do just that.

    In this talk, we’ll walk through a bunch of ways to abuse that capability: Resource-Based Constrained Delegation attacks, AD CS shenanigans, GPO and ACL abuse, SPN-in-the-middle attacks, weird stuff with Domain Computers, and a few other surprises. We’ll dig into how it works, why it’s possible, and what you can do about it. You’ll leave knowing exactly how attackers turn “net computer /add” into Domain Admin. But more importantly, you'll learn how to properly delegate this dangerous right!

#### Anti-Cast Training
- **When:** November 12, 2025
- **Where:** [Anti-Cast](antisyphontraining.com)
- **Talk Title:** PKI Foundations for Security Pros w/ Jake Hildreth
- **Abstract:**

    Do terms like hashing, signing, and certificates feel more confusing than clear?

    Public Key Infrastructure (PKI) has a reputation for being complicated, but it doesn’t have to be.

    Join us for a free one-hour training session with Jake Hildreth, Principal Security Consultant, on PKI Foundations for Security Professionals.

    He’ll teach core cryptography step by step—from symmetric encryption and shared keys to asymmetric encryption, hashing, signing, and certificates—then connect it all in a working PKI.

#### CodeMash
* **When:** January 13-16, 2025
* **Where:** Kalahari Resort, Sandusky, OH
* **Site:** [codemash.org](https://codemash.org)
* **Talk Title:** PKI Unlocked: A No-Math Primer for Builders
* **Abstract:**

    Public Key Infrastructure (PKI) has a reputation for being complicated, but it doesn’t have to be. In this talk, we'll walk together through core cryptography concepts step by step. We’ll start with symmetric encryption and shared keys, then move into asymmetric encryption, hashing, signing, and certificates. From there, we’ll connect the pieces and show how they come together in an actual PKI. Each concept builds on the last to you a clear, practical understanding of how PKI works and how to spot its components in the wild. No math, no crypto proofs, just the essentials developers need.

### Past Events

#### Blue Team Con
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

#### PancakesCon 6
- **When:** September 21, 2025
- **Where:** [pancakescon.com](https://pancakescon.com)
- **Talk Title:** PKI and Powerlifting!
- **Abstract:**

    In this talk, I will provide an no-math primer on basic PKI terms. We'll start with simple concepts like symmetric encryption and shared keys all the way up to asymmetric encryption, hashing, signing, certificates, until we end up with discussion about Public Key Infrastructure. Much like each PKI term builds on the previous terms, I'll also dicusss how you can get started in Powerlifting and build your strength!

#### HIP (Hybrid Identity Protection) Conf
- **When:** October 7-9, 2025
- **Where:** The Charleston Place, Charleston, SC
- **Site:** [hipconf.com](https://hipconf.com)
- **Talk Title:** End the ESCape Clause!
- **Abstract:**

    Explore a critical yet often overlooked threat: how seemingly low- or medium-severity AD CS misconfigurations, known as ESCs, can combine to compromise an entire Active Directory forest. This session, based on original research and real-world assessments, demonstrates three distinct ESC chains that escalate typical user access to Domain or Enterprise Admin. Learn why defenders often miss these risks when analyzing AD CS configurations in isolation and discover ESCalator, a PowerShell tool that surfaces escalation paths by linking multiple misconfigurations. Gain actionable insights to detect and mitigate these threats before attackers exploit them.
