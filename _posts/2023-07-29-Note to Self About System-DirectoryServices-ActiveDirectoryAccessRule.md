---
title: Note to Self About System.DirectoryServices.ActiveDirectoryAccessRule
creation_date: July 29, 2023
modified_date: 2026-02-15
tags: [powershell, security]
description: "Hey dummy: you have to use the proper .NET types for every argument of ActiveDirectoryAccessRule. A note-to-self so I stop re-learning this."
---
HEY DUMMY, YOU HAVE TO USE THE PROPER TYPES FOR ALL THE ARGUMENTS.

The first argument is either a SecurityIdentifier or an IdentityReference.

