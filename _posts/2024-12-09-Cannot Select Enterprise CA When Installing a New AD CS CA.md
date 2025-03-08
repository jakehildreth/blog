---
title: Cannot Select "Enterprise CA" When Installing a New AD CS CA
creation_date: December 9, 2024
modification_date: December 9, 2024
---
I am in the midst of deploying Active Directory Certificate Services (AD CS) Certification Authority (CA) for a presentation I'm giving in 40 hours. (Hello, demo gods! We're still friends, right?)

During the process, I decided to blow away the entire contents of my lab's Public Key Services container (CN=Public Key Services,Services,CN=Services,CN=Configuration,DC=BlueTuxedo,DC=DanglingSPNs,DC=lol) to "start clean". And in this process, I learned that AD CS will refuse to install in "Enterprise" mode without a Public Key Services container.

Enterprise mode is when your CA is AD-integrated - with all the good and bad that comes along with it. In my upcoming presentation, I'm going to be demoing attacks against AD that are possible only via Enterprise mode AD CS, so it's sort of important I get it working.

Thankfully, I remembered doing the same thing at my old job. A small voice in my head said "if you build it, they will come." So, I created a new container in the CN=Services,CN=Configuration,DC=BlueTuxedo,DC=DanglingSPNs,DC=lol and named in "Public Key Services".

~~Boom, "Enterprise CA" is now available.~~ Correction: You must close out of the AD CS installation process and start fresh. Otherwise, you will get hit with a weird error like:

> Active Directory Certificate Services setup failed with the following error: (WIN32: 1168 ERROR_NOT_FOUND).

What's that mean? ¯\_(ツ)_/¯

I hope this helps you the next time you make this same dumb mistake, Future Jake.
