---
title: Self-Hosting Pains
creation_date: July 21, 2023
modified_date: 2026-02-15
---
I host the Locksmith/BlueTuxedo Mattermost server on Oracle Cloud. It's free and fast, so why not?

The "why not?" is because I don't want to be a sysadmin anymore. 

I recently received a notification that the Mattermost server's TLS certificate was about to expire. This should happen automatically (I thought), so I began digging.

Since it's been about 3 months since I set up MM, I'd already forgotten everything about it.  I first began with poking around on a shell in the MM Docker container and randomly trying stuff I found on the internet. Shockingly, this did not work.

After a bit of digging and doc-reading, I saw Mattermost on Docker (in default config) uses a cert created on the host machine - not in the Docker container.

Thankfully, this wonderful person already put together a guide on how to renew the cert: [https://yaki.dev/renew ssl certificate of the mattermost/](https://yaki.dev/renew%20ssl%20certificate%20of%20the%20mattermost/)

I plan to create a cron job to run these commands for me on two-monthly basis and never think about this task again. :D 

EDIT (2025-01-27)
I should just include the commands here!

``` bash
cd docker
sudo docker-compose -f docker-compose.yml -f docker-compose.nginx.yml down
sudo bash scripts/issue-certificate.sh -d [domain.one],[domain.two] -o ${PWD}/certs
sudo docker-compose -f docker-compose.yml -f docker-compose.nginx.yml up -d
```