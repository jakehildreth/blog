---
title: Using the Clipboard in PowerShell
creation_date: May 2, 2024
modified_date: 2026-08-30
tags: [powershell]
description: "Set-Clipboard's -AsOSC52 parameter pipes remote output to your local clipboard over any terminal that supports OSC52. Neat."
---
If you’re using PowerShell 7.4 in Windows Terminal (or any terminal application that supports the OSC52 ANSI escape sequence), the `Set-Clipboard` cmdlet supports piping remote output to the local clipboard via the `-AsOSC52` parameter. 

You can even configure your PowerShell profile to automatically identify when you’re in a remote shell to automatically apply that parameter without you specifying it.

Set-Clipboard Documentation: [https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-clipboard?view=powershell-7.4](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-clipboard?view=powershell-7.4)

GitHub Issue that suggested the feature: [https://github.com/PowerShell/PowerShell/issues/18116](https://github.com/PowerShell/PowerShell/issues/18116)

