---
title: Locksmith Lab Setup
creation_date: June 28, 2023
modified_date: 2026-02-15
---
There’s been a lot of talk around my office recently about home labs. I think it’s time to share the details of the lab I use while writing and reviewing Locksmith code.

Hardware: Mid-2014 MacBook Pro

Remote Access platforms:
* macOS Screen Sharing 
* AnyDesk

Virtualization Platform: VirtualBox

2 Lab Machines (identical): 
* Windows Server 2022 Standard
* 1vCPU
* 8GB RAM
* 100GB Drive
* Headless startup 

Forest: horse.local

Domains:
* horse.local
* foal.horse.local

horse.local domain controller (DC) roles, features, and services:
* Active Directory Domain services (AD DS)
* AD Certificate Services (AD CS)
* Domain Name Server (DNS) 
* git
* Visual Studio (VS) Code Server w/Remote Tunnel

foal.horse.local DC roles, features, and services:
* AD DS
* AD CS
* DNS
* git
* VS Code Server w/Remote Tunnel

Remote Access to DCs:
* VS Code Remote Tunnel
* Remote Desktop Protocol (local network only)

