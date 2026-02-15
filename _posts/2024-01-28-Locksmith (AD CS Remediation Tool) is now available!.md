---
title: Locksmith (AD CS Remediation Tool) is now available!
creation_date: January 28, 2024
modified_date: January 28, 2024
---
## Mode 4 Now Fixes Ownership Issues Automatically!
No long-winded notes this month. Instead, I'll just wish my wife a happy birthday! She's the best. ❤️💜💙

Get it here: [https://github.com/TrimarcJake/Locksmith/releases/tag/v2024.1](https://github.com/TrimarcJake/Locksmith/releases/tag/v2024.1)

Or install from PSGallery:

`Install-Module -Name Locksmith -Scope CurrentUser`

## Improvements:
* ESC4 and ESC5 Ownership issues can now be auto-remediated with `-Mode 4`. - **@TrimarcJake**
* Improved RSAT installation process (if you don't have it installed yet.) - **@techspence**
* Modern custom object creation (no more `Add-Member` means slightly faster code that's much easier to read code) - **@TrimarcJake**
* README now shows how to use the `-Scans` parameter to limit your search to just a specific issue. - **@SamErde**
* We now have CONTRIBUTING and CODE_OF_CONDUCT docs. They're not quite where we want them, but soon! - **@TrimarcJake**
* PSScriptAnalyzer actions run on commit now, so we can check if there's anything hinky going on. - **@SamErde**
* Badges! Icons! - **@SamErde**

## Known Issues:
* Objects with both Allow and Deny ACEs reports two issues in output (I promise I'll *think* about working on this one for February. :D)

## Contributors:
* **@SamErde**
* **@techspence**
* **@TrimarcJake**

