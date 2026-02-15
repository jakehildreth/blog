---
title: Let's Talk About Nested Groups
creation_date: August 2, 2023
modified_date: 2026-02-15
---
Today, I sat in on a report review for a small-ish environment. The customer had a couple thousand users, some domain controllers, some GPOs, etc. And like almost every customer I've interacted with in the last 2 years of employment with Trimarc, they had a couple Critical issues.

But we're not here to talk about Critical issues today. Instead, a basic High issue: excessive membership in Active Directory  administration (AD Admin) groups due to <insert scary music> *Nested Groups! *More than 2% of the customer’s staff had AD Admin privileges because of these nested groups.

What's a nested group, you ask?

First some background:

For the purposes of this post, AD is a Windows-based identity management platform. It tracks who people are and determines what they can do in a Windows domain.

In AD, some of the basic identity types are users and computers. Users and computers can be grouped together - in groups, what a shocker! - to make administration more consistent, reliable, easy, etc. We love a well-designed group at Trimarc!

A "fun" thing Microsoft decided to do with groups in AD is to allow groups to be members of other groups. ie, Group A can be a member of Group B. In this case, Group A gains any rights and privileges granted to Group B. This can be very useful in certain administration methodologies.

One problem that immediately pops up is "circular" nesting. That's when Group A is a member of Group B, and Group B is also a member of Group A. Like the previous paragraph, Group A now earns Group B's rights, but now, *Group B also earns any rights granted to Group A*. Again, this *may* be useful in your weird form of administration, but it's confusing. It's very hard for a human to decipher what's going on in most cases.

However, the issue that impacted this customer was a more nefarious problem: nesting in AD Admin groups. 

At Trimarc, we pay particular attention to the groups we call AD Admin groups. These are groups that are expected to do AD administration: domain Administrators, Domain Admins (DA), Enterprise Admins, and Schema Admins.

Unknowingly, the customer added 2 groups containing regular user accounts to the DA group. The customer expected <10 AD Admins in their environment, but in reality, they had almost 150 AD Admins. That's 140ish additional users that could make an oopsie with their unnecessary powers and cause havoc in the forest.

How could this happen? Often, it's because a department-level group (like "ITStaff") gets added to an AD Admin group (like "Domain Admins") when the company is smaller and/or newer. This makes administration easier because all IT staff needed DA rights... when there was only one member on the IT team. As the company grows, new IT folks get hired and immediately get added to the ITStaff group thus receiving their DA privileges. 

At some point, the company hires a Managed Services Provider (MSP) to handle some technology-related tasks. Since they're "IT", the MSP's user group gets added to the ITStaff group... and suddenly the DA ranks swell to untenable levels.

In general, we love to congratulate customers for having "minimal AD Admin accounts" when they have <5 AD Admins (for very small-to-small environments) or <0.05% AD Admins (for larger environments). Needless to say, this customer did not meet our recommendations.

Thankfully, because this situation was unintentional, it will be fairly easy to remediate. But in many customer environments, we see AD Admin numbers like this that are "intentional". Instead of doing the (admittedly sometimes difficult) work of least-privilege administration, "admins" are granted AD Admin privileges because it Just Works™. How do you prevent this unexpected over-privileging?
1. Audit your AD Admin group memberships. Any changes to the membership of these highly-privileged groups should be firing off alerts in someone's face. And VERIFY your auditing takes nesting into account!
2. Work to eliminate unnecessary AD Admin privileges. It will be much easier to remove nested groups from the AD Admin groups if no one needs AD Admin privileges.

