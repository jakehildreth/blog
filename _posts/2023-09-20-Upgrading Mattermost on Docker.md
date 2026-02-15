---
title: Upgrading Mattermost on Docker
creation_date: September 20, 2023
modified_date: 2026-02-15
---
For the last two months-ish, I've been getting notifications that the Locksmith/BlueTuxedo Mattermost server was going out of support. Two days ago, I started getting notifications in the mobile app that the server was officially unsupported.

Like any good sysadmin, I ignored these warnings until one of my users (Sam on the Locksmith team) reported he was receiving out-of-support notifications in the mobile app too.

I looked for upgrade instructions off and on over the last few months but found nothing satisfactory. But today, our good lord Google smiled upon me and revealed the truth via this forum post: https://forum.mattermost.com/t/upgrading-mm-docker-install/14887/7

I followed the instructions to the T... and the system didn't work. Unfortunately, I know almost nothing about Docker and couldn't really troubleshoot. I could see the Postgres and Mattermost containers starting up, but that was about it. 

After a few minutes of `sudo docker-compose down` and `sudo docker-compose up`,
I went back to the installation instructions. And there it was... since I am using nginx, I had to use the following command instead:
`sudo docker-compose -f docker-compose.yml -f docker-compose.nginx.yml up -d`
5 minutes later, everything was back online, and I was a happy boy again.
