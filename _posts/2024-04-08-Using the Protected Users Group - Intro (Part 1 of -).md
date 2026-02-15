---
title: Using the Protected Users Group - Intro (Part 1 of ?)
creation_date: April 8, 2024
modified_date: 2026-02-15
---
The Protected Users group (PUG) is a universal group added to Active Directory in Windows Server 2012 R2. It enables and enforces a series of **non-configurable** protections that greatly enhance the security of members of the group:

* Eliminates credential caching
* Eliminates the use of any authentication type other than Kerberos AES
* Prevents delegation (impersonation)
* Limits Kerberos tickets to 4 hours without the option to renew automatically

(Source: https://learn.microsoft.com/en-us/windows-server/security/credentials-protection-and-management/protected-users-security-group)

These protections eliminate a vast majority of the attacks on accounts and should be required for all AD Admins (built-in Administrators, Domain Admins, Enterprise Admins, and Schema Admins) at a minimum with an eventual goal to add as many privileged accounts as possible.

While this group has been around for 10 years, it's still criminally underutilized in enterprises large and small. This is because the security settings are non-configurable and stamp out a majority of bad AD Admin behavior.

I plan to use this series to write a basic framework for using the Protected Users group in a way that is as smooth and simple as possible.

In Part 2 of this series, we'll talk about credential caching, why it's bad, and how the Protected Users group can help.
