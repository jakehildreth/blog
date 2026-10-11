---
title: You Need An Active Directory Auditing Group!
creation_date: October 9, 2024
modified_date: 2026-08-30
tags: [security]
description: "After assessing 6-10 AD forests a year, one constant: every org needs a dedicated AD auditing group. Here's why and how."
---
In my work as the Service Lead for the Trimarc Active Directory Security Assessment (ADSA), I personally assess 6-10 AD forests per year and perform Subject Matter Expert review/QA on *so many* more. (Folks... I've seen some *stuff*.) Every assessment contains the same four phases: **c**ollection, **p**rocessing, **a**nalysis, and **p**resentation.

In the first phase (collection), Trimarc provides the customer a bespoke PowerShell script which collects a metric shedload of data from the forest using all Microsoft tools - primarily the `ActiveDirectory` and `GroupPolicy` PowerShell modules. During collection, the customer runs the collector in their environment as a regular user account. This account usually has been granted no special privileges. In most environments, the collection tool runs great using a normal user account due to the open nature of AD.

What do I mean by "open nature"? Out of the box, a normal user can read most properties on most objects in a forest. But this openness is a double-edged sword. As you might suspect, this open approach also means any attacker that happens to land in your environment via ~~elite hacking~~ phishing can plunder the environment to find multiple gaps, holes, and paths to absolutely pwn your environment in minutes[^1].

Some organizations have recognized the open nature of AD can be less than ideal. To reduce exposure of possibly sensitive information, they take steps to lock down a regular user's visibility as much as possible. Occasionally such measures work really well, but in most cases, the decrease in usability, reliability, and consistency outstrips the nominal increases in security. As Specter Ops and others have shown, multiple indirect path leading to AD compromise can almost always be found regardless. Hiding objects and attributes from normal users can make an attacker's life more difficult, but it will never completely eliminate the risk.

In such environments, Trimarc tooling falls down. Sometimes it falls down REALLY hard. Our collection tools are designed to use the exact same methods for querying AD a sysadmin would use, and they are LOUD and PROUD while performing their collection duties. (For serious, if your security operations center isn't seeing Trimarc collection tool activity, you've got bigger issues.)

That's why one of the pre-requisites of a Trimarc ADSA is read-only access to all objects and attributes in the forest (excluding confidential attributes; we're not monsters.) It's very difficult to assess that which you cannot see. Could Trimarc create data collection tools that are more stealthy and take advantage of misconfigurations to gather data from a forest? Absolutely! But that flies directly in the face of our blue team, above board, do the right thing ethos.

In situations where our tooling continues falling down despite assurances that our assessment account can read everything, we ask the customer to add the account running the collection tool to either:
1. directly grant `Read` rights to the assessment account
2. add the assessment account to an auditing group that already has `Read` rights on all objects in the forest.

In most cases, this request is honored and our collector is happy. But occasionally, the customer tells us they will not grant an individual accounts such rights (correct answer!) and/or they do not have an auditing group.

In those exceedingly rare instances, we request the creation of the auditing group and coach the customer through the best way to accomplish the goal. But this process gets tedious, and if you're going to do something twice, you should probably automate it.

To that end, I present to you a new PowerShell module: [ADAuditingGroup](https://github.com/Trimarc/ADAuditingGroup). This module is a collection of small functions developed internally to assist customers in creating their own audit group:
- `New-ADAuditingGroup` - Creates a global group in the root domain and names it ADAuditingGroup.
- `New-ADAuditingGroupMember` - Creates a user or users with an '-audit' suffix and adds them to the newly created group.
- `Set-ADAuditingGroupAcl` - Creates an ACE that grants `ReadProperty, GenericExecute` on all attributes of an object to a specific group then adds that ACE to all objects in the forest (except the `System` and `Configuration` containers).
- `Remove-ADAuditingGroupAcl` - Creates an ACE that grants `ReadProperty, GenericExecute` on all attributes of an object to a specific group and removes that ACE from all objects in the forest.

[^1]: Trimarc defines a Critical issue as any single issue in which a large number of users can compromise AD in one step OR a combination of issues in which all users can compromise AD in a few steps. We see an average of 1.6 Critical issues per forest!