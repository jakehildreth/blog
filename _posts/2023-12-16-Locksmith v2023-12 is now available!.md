---
title: Locksmith v2023.12 is now available!
creation_date: December 16, 2023
modified_date: 2026-02-15
tags: [locksmith, adcs]
description: "People are using Mode 4 auto-remediation in the wild, which terrified us into finally giving it some love."
---
This month, the Locksmith team discovered people are actually using Mode 4 (auto-remediation) in the wild. To be honest, we let Mode 4 languish because none of us would trust a fully automated remediation tool... even if we wrote it!

But since it's being used, we should definitely improve it. The new Mode 4 is much more explicit about what the issue is, why it's an issue, and how it will be remediated.

Lastly, the Operational Impact is spelled out in plain language and color coded so it's more obvious when a fix may negatively impact operations:

![2023-12-16-Locksmith v2023-12 is now available!]({{ site.baseurl }}/images/2023-12-16-Locksmith%20v2023-12%20is%20now%20available!.png)

After Locksmith is done fixing stuff on your behalf, you'll get an indicator that it's done instead of just dropping back to the console.

We also resolved some output issues (fewer duplicates), false positives (bitwise math is weird), and cleaned up the scripts used to build the project.

Grab it here: _https://github.com/TrimarcJake/Locksmith/releases/tag/v2023.12_

OR

`PS> Install-Module Locksmith`

Thank you for using 💜 Locksmith 💜

