---
title: A Dive into AutomatedLab - Infrastructure as Code for PowerShellers
creation_date: 2025-05-16
modified_date: 2025-07-05
---
![AutomatedLab Logo]({{ site.baseurl }}/images/Pasted%20image%2020250704101624.png)

While building [BlueTuxedo](https://github.com/jakehildreth/BlueTuxedo) (BT) in 2023, I was fortunate to work closely with [Jim Sykora](https://www.adminsdholder.com). In support of the BT project, Jim built out a small two-domain forest in his homelab for us to share. He would set up some weird ADI DNS stuff, and I would update BT to detect that weird stuff. It worked really well.

After BT was released, I began using that little lab for everything. [PowerPUG!](https://github.com/jakehildreth/PowerPUG) was written almost 100% in that lab. [Locksmith](https://github.com/jakehildreth/Locksmith) was maintained in that lab for months, nay, years! It's been really reliable.

But Jim is currently reconfiguring his homelab to be more... Jim-like. Multiple hosts, multiple architectures, multiple hypervisors, and multiple IaC methods. I'm super-excited to see what he builds, but this means the lab I've relied upon for years is no longer available.

Thankfully, [my employer](https://www.semperis.com) recently sent me a sweet-ass NUC! It's got an Intel Core i7 + 96GB RAM + 2TB m.2 drive. It flies. I'm using it to create two labs types: one for testing Semperis assessment tools and one for testing hare-brained ideas. After searching around a bit for the Infrastructure as Code (IaC) tools that fit me best, I'm going to use [AutomatedLab](https://automatedlab.org/en/latest/)!
## Who is AL?
>AutomatedLab (AL) enables you to setup test and lab environments on Hyper-v or Azure with multiple products or just a single VM in a very short time. There are only two requirements you need to make sure: You need the DVD ISO images and a Hyper-V host or an Azure subscription.

[Source](https://github.com/AutomatedLab/AutomatedLab/blob/develop/README.md)

AutomatedLab has been around for a while. The [AL repository](https://github.com/AutomatedLab/AutomatedLab) was created in 2016 and has received constant maintenance since then. It strives to make deploying a lab easy and consistent. All in all, it achieves those goals.
## What Can AL Do For You?
If you're a Windows admin, you're likely at least *familiar* with PowerShell. And that means you've seen the "Verb-Noun" structure of PowerShell commands and cmdlets. While sometimes overly verbose (ahem... Graph), PowerShell makes it really easy for non-developers to dip their toes into development concepts without feeling like you're learning a foreign language.

AutomatedLab takes advantage of the average Windows admin's PowerShelly knowledge to wrap a ton of functionality up into easy-to-use cmdlets that are fairly descriptive and require minimal training to understand. Each cmdlet performs a typical task to be completed during typical lab setup stuff. And many of the cmdlets require little-to-no configuration to work properly.

As an example, let's step through one of the sample scripts provided in the AL package: [`SmallLab 2012R2 Single Server.ps1`](https://github.com/AutomatedLab/AutomatedLab/blob/develop/LabSources/SampleScripts/HyperV/SmallLab%202012R2%20Single%20Server.ps1) This script deploys a Domain Controller and a member server in a single-domain Active Directory (AD) forest.
### Prerequisites
To follow along at home, you need the following:
* A host machine with 8GB memory, 6GB free space, and Hyper-V enabled
* A Windows Server 2012 R2 Datacenter ISO
* A Windows Server 2008 R2 Datacenter ISO
* The AutomatedLab module installed
* An elevated PowerShell 7 session

To install AL, you can do `Install-Module -Name AutomatedLab -Scope CurrentUser -Force` or grab the latest MSI installer from [https://github.com/AutomatedLab/AutomatedLab/releases](https://github.com/AutomatedLab/AutomatedLab/releases).

After installation, place your ISOs in `C:\LabSources\ISOs`. To view the whole example script at once, you can find a copy of `SmallLab 2012R2 Single Server.ps1` in `C:\LabSources\SampleScripts\HyperV\`.

BTW: If you don't have ISOs for those old af OSes, you can use the Server 2022 ISO instead. Just replace the Operating System names in the script/examples with `Windows Server 2022 Datacenter (Desktop Experience)`. Are you too ~~lazy~~ efficient to modify the script yourself? No worries. Get a copy here: [`SmallLab 2022 Single Server.ps1`](https://gist.github.com/jakehildreth/beb08e5ce20c6f6f2c8ff5e967eb1e0c#file-smalllab-2022-single-server-ps1)

Alright, let's do itttttttt.
### A Lab Has ~~No~~ a Name
Every lab needs a name! This line sets the lab's name for use later in the script.
``` powershell
$labName = 'SmallServer1'
```
### A Lab Must Be Defined
This command creates the required file structure for your current lab. By default, this is just a folder in `C:\ProgramData\AutomatedLab\Labs\` named after `$labName`. In this folder, AL stores all lab configuration data as XML files. Don't worry, you ~~don't~~ shouldn't need to dig into the XML directly. 
``` powershell
#create an empty lab template and define where the lab XML files and the VMs will be stored
New-LabDefinition -Name $labName -DefaultVirtualizationEngine HyperV
```
**Cool thing:** if you don't define your lab's `-Name`, a semi-random name is generated for you. 😎
### A Lab Needs a Network
A virtual network is needed to allow the VMs in your lab to communicate with each other. By default, this is an "Internal" network. In Hyper-V parlance, this means a network where the VMs can communicate with the host. You can also configure External switches which allow the VMs internet access, but that's outside the scope of this article.
``` powershell
#make the network definition
Add-LabVirtualNetworkDefinition -Name $labName -AddressSpace 192.168.81.0/24
```
**Cool things:** if you don't define an `-AddressSpace`, AL will find an available 192.168.x.x network on your behalf. 😎
### Lab Machines Need Local Admins
To install required software, you need a local administrator account. This command defines the admin's name and password. 
``` powershell
Set-LabInstallationCredential -Username Install -Password Somepass1
```
**Cool thing:** if you don't run this command, the local administrator username is set to "Administrator". If you don't define the password, it gets set to "Somepass1". 😎
### My Labs Need Active Directory
Active Directory (AD) is still the most used identity platform in the world, so it's likely you'll want to have AD in your lab. AD literally pays my bills, so I sort of *have* to include it. This command defines the root domain of the forest along with the domain administrator's username and password.
``` powershell
#and the domain definition with the domain admin account
Add-LabDomainDefinition -Name test1.net -AdminUser Install -AdminPassword Somepass1
```
**Cool thing:** you don't *have* to run this command at all. If you define a `-DomainName` when defining your Domain Controller (DC) machine (shown below), the root domain is still created. In this case, the domain administrator's username is "Administrator" and its password is "Somepass1". 😎
### Active Directory Needs a Domain Controller
AD requires a DC. Sorry, I guess? This command defines all the stuff a VM needs including the "Role" the VM will play in your lab. Along with `RootDC`, there are a bazillion other [Available Roles](https://automatedlab.org/en/latest/Wiki/Roles/roles/) to assign your VMs. Some interesting ones I've used are `CaRoot`, `FirstChildDC`, and `WindowsAdminCenter`.
``` powershell
#the first machine is the root domain controller. Everything in $labSources\Tools get copied to the machine's Windows folder
Add-LabMachineDefinition -Name S1DC1 -Memory 512MB -Network $labName -IpAddress 192.168.81.10 `
    -DnsServer1 192.168.81.10 -DomainName test1.net -Roles RootDC `
    -ToolsPath $labSources\Tools -OperatingSystem 'Windows Server 2012 R2 Datacenter (Server with a GUI)'
```
**Cool thing:** half this stuff is also unnecessary. AL just figures it out for you. 😎
### (Most) Labs Need Tools
This is just another server. Not much interesting here except... do you see that `-ToolsPath $labSources\Tools` bit? You can use AL to copy over a bunch of tools you may need on your VMs. For example, I currently copy over Locksmith, Certify, and Rubeus in all my installs.
``` powershell
#the second just a member server. Everything in $labSources\Tools get copied to the machine's Windows folder
Add-LabMachineDefinition -Name S1Server1 -Memory 512MB -Network $labName -IpAddress 192.168.81.20 `
    -DnsServer1 192.168.81.10 -DomainName test1.net -ToolsPath $labSources\Tools `
    -OperatingSystem 'Windows Server 2008 R2 Datacenter (Full Installation)'
```
**Cool thing:** the directory shown in `-ToolsPath` is automatically excluded from Windows Defender. Load up your hax!! 😎
### Is it Lab Yet?
Up until now, you've just been defining your lab. But with this command:
``` powershell
Install-Lab
```
 The magic happens, and AL starts doing its thing. In this step, AL does one or more of the following:
* creates the network
* loads the required ISOs
* creates a virtual hard disk for each VM
* creates a "base image" for each OS in the lab (if a base image doesn't already exist)
* sets the RAM and Network on each VM
* wires the ISOs and VMs together
* boots the VM
* copies over Tools
* installs required software/roles
* creates a forest and child domains
* joins member computers to the forest
* runs post-install scripts
* runs Pester tests to verify deployment occurred as expected
* and so much more!

It's really wild to watch it all occur without any interaction. Here's an example of output you'd see while deploying:
``` powershell
~
PS> Install-Lab
09:21:14|00:13:30|00:00:04.686| Estimated (additional) local drive space needed for all machines: 4 GB
09:21:14|00:13:30|00:00:04.930| Location of Hyper-V machines will be 'C:\AutomatedLab-VMs'
09:21:14|00:13:30|00:00:04.938| Done
09:21:14|00:13:30|00:00:00.000| Validating lab definition
09:21:15|00:13:32|00:00:01.468| - Success
09:21:15|00:13:32|00:00:01.630| Lab 'SmallServer1' hosted on 'HyperV' imported with 2 machines
09:21:16|00:13:32|00:00:00.000| Creating virtual networks
09:21:16|00:13:32|00:00:00.000| - Creating Hyper-V virtual network 'SmallServer1'
09:21:18|00:13:35|00:00:02.721|   - Done
09:21:18|00:13:35|00:00:02.726| - Done
09:21:18|00:13:35|00:00:02.738| done
09:21:18|00:13:35|00:00:00.000| Creating base images
09:21:18|00:13:35|00:00:00.021| - All base images were created previously
09:21:20|00:13:36|00:00:01.332| - Done
09:21:20|00:13:36|00:00:01.335| done
09:21:20|00:13:36|00:00:00.000| Creating Additional Disks
09:21:21|00:13:38|00:00:01.560| - Done
09:21:21|00:13:38|00:00:00.000| Creating VMs
09:21:21|00:13:38|00:00:00.091| - The hosts file has been updated with 4 records. Clean them up using 'Remove-Lab' or manually if needed
09:21:21|00:13:38|00:00:00.000| - Waiting for all machines to finish installing
09:21:21|00:13:38|00:00:00.000|   - Creating HyperV machine 'S1Server1'.....
09:21:31|00:13:47|00:00:09.390|     - Done
09:21:31|00:13:47|00:00:00.000|   - Creating HyperV machine 'S1DC1'.....
...snip...
09:45:04|00:37:20|00:00:00.000| Adding lab machines to C:\Users\JakeHildreth/.ssh/known_hosts
09:45:08|00:37:25|00:00:04.219| - Done

Starting discovery in 60 files.
Discovery found 63 tests in 3.12s.
Running tests.
[+] C:\Users\JakeHildreth\Documents\PowerShell\Modules\AutomatedLabTest\5.57.0\tests\00General.tests.ps1 199ms (80ms|80ms)
[+] C:\Users\JakeHildreth\Documents\PowerShell\Modules\AutomatedLabTest\5.57.0\tests\RootDC.tests.ps1 4.63s (4.52s|40ms)
Tests completed in 7.83s
Tests Passed: 5, Failed: 0, Skipped: 0, Inconclusive: 0, NotRun: 58
```
### That *Was* Cool... But What Happened?
And finally...
``` powershell
Show-LabDeploymentSummary
```
This command outputs a ton of useful information. It's not necessary, but it is *nice.*

Example:
``` powershell
PS> Show-LabDeploymentSummary
09:54:13|00:46:30|00:09:09.227| ---------------------------------------------------------------------------
09:54:13|00:46:30|00:09:09.230| Setting up the lab took 0 hour, 46 minutes and 30 seconds
09:54:13|00:46:30|00:09:09.232| Lab name is 'SmallServer1' and is hosted on 'HyperV'. There are 2 machine(s) and 1 network(s) defined.
09:54:13|00:46:30|00:09:09.233| ----------------------------- Network Summary -----------------------------
09:54:13|00:46:30|00:09:09.264|
09:54:13|00:46:30|00:09:09.266| Name         AddressSpace    SwitchType AdapterName IssuedIpAddresses
09:54:13|00:46:30|00:09:09.268| ----         ------------    ---------- ----------- -----------------
09:54:13|00:46:30|00:09:09.273| SmallServer1 192.168.81.0/24   Internal                             0
09:54:13|00:46:30|00:09:09.274|
09:54:13|00:46:30|00:09:09.275| ----------------------------- Domain Summary ------------------------------
09:54:13|00:46:30|00:09:09.308|
09:54:13|00:46:30|00:09:09.311| Name      Administrator Password  RootDomain
09:54:13|00:46:30|00:09:09.312| ----      ------------- --------  ----------
09:54:13|00:46:30|00:09:09.314| test1.net Administrator Somepass1
09:54:13|00:46:30|00:09:09.315|
09:54:13|00:46:30|00:09:09.316| ------------------------- Virtual Machine Summary -------------------------
09:54:13|00:46:30|00:09:09.343|
09:54:13|00:46:30|00:09:09.344| Name      DomainName IpV4Address   Roles                OperatingSystem                                     Local Admin   Password
09:54:13|00:46:30|00:09:09.346| ----      ---------- -----------   -----                ---------------                                     -----------   --------
09:54:13|00:46:30|00:09:09.347| S1Server1 test1.net  192.168.81.20 {WindowsAdminCenter} Windows Server 2022 Datacenter (Desktop Experience) Administrator Somepass1
09:54:13|00:46:30|00:09:09.348| S1DC1     test1.net  192.168.81.10 {RootDC}             Windows Server 2022 Datacenter (Desktop Experience) Administrator Somepass1
09:54:13|00:46:30|00:09:09.350|
09:54:13|00:46:30|00:09:09.351| ---------------------------------------------------------------------------
09:54:13|00:46:30|00:09:09.352| Please use the following cmdlets to interact with the machines:
09:54:13|00:46:30|00:09:09.353| - Get-LabVMStatus, Get, Start, Restart, Stop, Wait, Connect, Save-LabVM and Wait-LabVMRestart (some of them provide a Wait switch)
09:54:13|00:46:30|00:09:09.354| - Invoke-LabCommand, Enter-LabPSSession, Install-LabSoftwarePackage and Install-LabWindowsFeature (do not require credentials and
09:54:13|00:46:30|00:09:09.359|   work the same way with Hyper-V and Azure)
09:54:13|00:46:30|00:09:09.360| - Checkpoint-LabVM, Restore-LabVMSnapshot and Get-LabVMSnapshot (only for Hyper-V)
09:54:13|00:46:30|00:09:09.362| - Get-LabInternetFile downloads files from the internet and places them on LabSources (locally or on Azure)
09:54:13|00:46:30|00:09:09.363| ---------------------------------------------------------------------------
```
### Now You Try!
So now that you understand what's happening in the script, you can try it yourself! Open an elevated PowerShell 7 prompt and run the following:
``` powershell
& 'C:\LabSources\SampleScripts\HyperV\SmallLab 2012R2 Single Server.ps1'
```

OR if you downloaded the 2022 version linked above:
``` powershell
& 'C:\[DOWNLOAD_LOCATION]\SmallLab 2022 Single Server.ps1'
```

In a while, you'll have a lab!
### Clean Up, Clean Up
When you're all done with your lab (or... let's be honest here... screwed it up beyond repair 🤷), you can run one command to remove all your VMs, switches, virtual hard disks, etc.:
``` powershell
Remove-Lab
```

Example:
``` powershell
PS> Remove-Lab

Confirm
Are you sure you want to perform this action?
Performing the operation "Remove the lab completely" on target "SmallServer1".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): Y
09:55:01|00:47:17|00:00:00.000| Removing lab 'SmallServer1'
09:55:01|00:47:17|00:00:00.001| - Removing lab sessions
09:55:01|00:47:17|00:00:00.109| - Removing imported RDS certificates
09:55:01|00:47:17|00:00:00.152| - Removing lab background jobs
09:55:01|00:47:18|00:00:00.252| - Removing Lab VM 'S1Server1' (and its associated disks)
09:55:02|00:47:18|00:00:00.851| - Lab VM 'S1Server1' has been removed
09:55:02|00:47:18|00:00:00.881| - Removing Lab VM 'S1DC1' (and its associated disks)
09:55:02|00:47:19|00:00:01.450| - Lab VM 'S1DC1' has been removed
09:55:02|00:47:19|00:00:01.510| - Removing entries in the hosts file
09:55:02|00:47:19|00:00:01.557| - Removing SSH known hosts
09:55:02|00:47:19|00:00:01.604| - Removing virtual networks
09:55:05|00:47:22|00:00:04.363| - Removing Lab XML files
09:55:05|00:47:22|00:00:04.382| - Done removing lab 'SmallServer1'
```
Check your Hyper-V Management console. All clean!
## What Else Can AL Do For You?
Do you prefer to run VMs on Azure? AL's got you.

Do none of the existing Roles fit your needs? Create custom Roles!

Do you want to run post-installation configuration tasks? No problem!

Want to run multiple labs simulaneously? Sure!

There's a bunch more, but I'm just starting my AL journey. So maybe I'll write a follow-on article down the road. Maybe. Lotta squirrels out there to look at.
## What Can *I* Do For You Today?
In early June, I started playing with AutomatedLab more seriously. I wanted to create a script that would create a small PKI-focused lab for use when working on Locksmith, Locksmith 2, and ESCalator. I wanted v0.0.1 of the script to have the following specs:
* Must create a lab including:
	* 1 Domain Controller
	* 1 Root Certification Authority
	* 1 Privileged Access Workstation
* Must accept a Lab Name, Root Domain Name, and a few other parameters from the command line.
* Must validate the Lab Name & Root Domain Name are unique on the host and not too long.
* Must use an External Switch so VMs have internet access.
* Must *create* an External Switch if none exists.
* Must assign unique IPs to all VMs in the Lab.

Does that sound like something you want? If so, I present [`Build-ALPKILab.ps1`](https://gist.github.com/jakehildreth/d7e00d2d342896caab3d27d0344280f7#file-build-alpkilab-ps1). This script is super-simple and doesn't do even ⅓ of the things I want the final script to do. But what it *does* do is pretty cool. Give it a Lab Name and a Domain Name and sometime later, you have a fresh lab loaded with stuff you need. No muss, no fuss.
## Fin
That's it for today. I hope I was able to demonstrate how simple using AutomatedLab can be. If you want more info, please check out the full AL documentation site at [https://automatedlab.org/en/latest/](https://automatedlab.org/en/latest/). Then once you've whet your whistle with IaC in PowerShell, start looking into more powerful solutions like Terraform, Ansible, Chef, Puppet, DSC, and so many more! Then teach me what you learn. 😄

And of course, if you have any comments or suggestions for my v0.0.1 script, please post a comment on the gist or [find me elsewhere](https://jakehildreth.com). I'm around. 😉