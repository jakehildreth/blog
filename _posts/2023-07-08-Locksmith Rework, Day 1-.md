---
title: Locksmith Rework, Day 1
creation_date: July 8, 2023
modified_date: 2026-02-15
---
It's 6:16am on a Saturday, so obviously it's time to work on code. 

This morning, I am attempting to build the next release of Locksmith using the tools created by Przemyslaw Klys. 

First of all, I spent a few minutes removing all the 
`Clear-Host `
and 
`$Logo `
lines from the existing code. They are vanity plates I did for fun... and really, who cares?

Then, I updated Build-Module.ps1 with the correct metadata for the next release of Locksmith. 

After taking care of the basic housekeeping, I tried my first build.

### Problem 1 - PSPublishModule is not installed.
```powershell
PS C:\Users\Administrator\Documents\Locksmith\Build> .\Build-Module.ps1
Import-Module : The specified module 'PublishModule' was not loaded because no valid module file was found in any module directory.                             At C:\Users\Administrator\Documents\Locksmith\Build\Build-Module.ps1:1 char:1    + Import-Module PublishModule -Force                                  
```
`
This was an expected error since I have not yet installed "PSPublishModule" which is required for Build-Module.ps1. I just wanted to see what would happen if I didn't manually install it.

Thankfully, Przemyslaw provided guidance on installing this module in his PR:
`Install-Module PSPublishModule -Force -Verbose`

However, this brought us to...

### Problem 2 - 'PSScriptAnalyzer' is currently in use.
``` powershell
PS C:\Users\Administrator\Documents\Locksmith\Build> Install-Module -Name PSPublishModule -AllowClobber -Force
WARNING: The version '1.21.0' of module 'PSScriptAnalyzer' is currently in use. Retry the operation after closing the applications.
```
AND
### Problem 3  - Previously installed version of Pester conflicts with the new version.
```powershell
PackageManagement\Install-Package : A Microsoft-signed module named 'Pester' with version '3.4.0' that was previously installed conflicts with the new module 'Pester' from publisher 'CN=DigiCert Assured ID Root CA, OU=www.digicert.com, O=DigiCert Inc, C=US' with version '5.5.0'. Installing the new module may result in system instability. If you still want to install or update, use -SkipPublisherCheck parameter.
```
`
Both issues seemed fairly easy to resolve. I closed the open terminals on my Mac and tried again. But then I got...
### Problem 4 - Multiple "`<package>` is currently in use" Warnings 
When attempting to install PSPublishModule this time, I got 3 warnings, but no errors. Progress? I was not filled with confidence, so I closed everything running in my lab and started fresh.

This time, PSPublishModule was installed successfully. There were still a few warnings, but I felt confident moving on to the next step. So, let's try our first Build!

### Problem 5 - An immediate Build-Module.ps1 error.
This issue was pretty small in the scheme of things. The build actually succeeded, but I received the red text at the beginning because Line 1 of Build-Module.ps1 was:
`Import-Module PublishModule -Force`
When it should have been:
`Import-Module PSPublishModule -Force`
Now **this** is a bug I can fix.  I updated the build script, and everything was fine.

Now let's move on to installing and building on a fresh machine!
### Attempting to build on a new machine.
I decided to try and add auto-installation of PSPublishModule to the Build-Module.ps1 script to make it easier to use by adding the following:
```powershell
$ErrorActionPreference = 'Stop'

if (Get-Module -Name 'PSPublishModule' -ListAvailable) { 
    Write-Information 'PSPublishModule is installed.'
} else {
    Write-Information 'PSPublishModule is not installed. Attempting installation.'
    try {
        Install-Module -Name PSPublishModule -AllowClobber -Scope CurrentUser -Force
    } catch {
        Write-Error 'PSPublishModule installation failed.'
    }
}

Import-Module -Name PSPublishModule -Force
```
I quickly ran into the same 'package in use' and Pester conflict issues I noticed before.

I modified my code to this:  
```powershell
$ErrorActionPreference = 'Stop'

if (Get-Module -Name 'PSPublishModule' -ListAvailable) { 
    Write-Information 'PSPublishModule is installed.'
} else {
    Write-Information 'PSPublishModule is not installed. Attempting installation.'
    try {
        Install-Module -Name Pester -AllowClobber -Scope CurrentUser -SkipPublisherChck -Force #ADDED THIS
        Install-Module -Name PSPublishModule -AllowClobber -Scope CurrentUser -Force
    }
    catch {
        Write-Error 'PSPublishModule installation failed.'
    }
}
```

And all was good!

