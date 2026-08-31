---
title: Presenting Tactical Speed Square
creation_date: July 30, 2023
modified_date: 2026-02-15
tags: [homelab]
description: "Couch-bound after hernia surgery, so obviously I built the thing the Locksmith team needed: a standardized test harness. Aka The UnLocksmith."
---
**aka The UnLocksmith**

I had a couple hernias repaired Friday and thus planned to be pretty much couch-bound all weekend. So of course I woke up Saturday morning with a desire to work on code. 

For a couple months, the Locksmith team has needed a standardized way to test code changes. The core team has labs of various shapes, sizes, and capabilities, so I decided to not go the auto-generated vulnerability route… yet. 

Instead, I decided to write a script that would generate a bunch of vulnerable templates and objects with known names and configs as well as disable auditing on CAs, and enable the SAN flag on CAs. 

More importantly, the script creates a bunch of templates and objects that recreate acceptable configurations which should not be identified by AD CS vulnerability scanning tools (like Locksmith, Certify, Certipy, etc.)

Grab the tool here: [https://github.com/TrimarcJake/Locksmith/blob/experimental/Tests/Invoke-TSS.ps1](https://github.com/TrimarcJake/Locksmith/blob/experimental/Tests/Invoke-TSS.ps1)

This is all very manual and very fragile for now, but it gets the job done and was fun to write!

As for the name… well what's the best way to open a lock? Hint: [https://www.youtube.com/shorts/Eii8JroovjI](https://www.youtube.com/shorts/Eii8JroovjI)
