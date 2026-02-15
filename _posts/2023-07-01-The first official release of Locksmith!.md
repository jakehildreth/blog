---
title: The first official release of Locksmith!
creation_date: July 1, 2023
modified_date: July 1, 2023
---
The Locksmith core team (**@SamErde**, **@techspence**, **@TrimarcJake**) has settled on a monthly release cadence. New releases should come out during the first weekend of every month and will include any work performed during the preceding month. If you have any feature requests, please raise an Issue! At this point, we are accepting almost every request, no matter how wild!

## Improvements:
* All modes: Auditing check now uses FQDNs to contact CAs which should improve results in multi-domain forests. (RGR)
* All modes: ESC2 check now includes "Any Purpose" EKU. (**@TrimarcJake**)
* All modes: Direct members of the domain Administrators, Cert Publishers, and Domain Admins groups from the invoking domain and direct members of the Enterprise Admins group have been added to the $SafeUsers list. This should minimize false positives in ESC1, ESC2, ESC4, and ESC5 checks. (**@TrimarcJake**)
* Modes 2 & 3: Technique IDs have been added to CSV output for easier reading. (**@SamErde**)
* General: usability improvements. (**@SamErde**)

## Major bugs resolved:
* All modes: ESC8 checks now work in Powershell 7. (**@TrimarcJake**)
* Mode 4: if no issues are found, Locksmith no longer crashes when attempting to create a script to revert its changes. (**@techspence**)

## Known Issues:
* All modes: In multi-domain forests, red error text will flash immediately after invoking Locksmith. This is because Get-ADGroupMember doesn't allow the use of global catalog servers, and **@TrimarcJake** is too tired to fix it right now.
* All modes: related to the issue above, domain Administrators, Cert Publishers, and Domain Admins from domains other than the domain where Locksmith was initially invoked are not added to the $SafeUsers list. These results are false positives.
* All modes: Members of groups nested in domain Administrators, Cert Publishers, Domain Admins, and Enterprise Admins are not added to the $SafeUsers list.

## Contributors to this release:
* "RGR" (not on GitHub)
* **@SamErde**
* **@techspence**
* **@TrimarcJake**

