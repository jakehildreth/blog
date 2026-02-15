---
title: Restoring a Mistakenly-Deleted Branch in GitHub
creation_date: October 26, 2024
modified_date: October 26, 2024
---
## Back Story

([tl;dr here](#tldr))

While working on improved [ESC8](https://posts.specterops.io/certified-pre-owned-d95910965cd2) detections for [Locksmith](https://github.com/TrimarcJake/Locksmith), I built a thing that temporarily disabled certificate validity checks for the current PowerShell session. This was intended to be part of Locksmith 2024.9, but the .NET interface I used was only supported in WIndows PowerShell aka Desktop Edition aka PS5.1. PS7/.NET Core would complain about the interface no longer existing.

The Locksmith team decided to skip the 2024.9 release because we hate releasing clearly buggy code. (Subtly buggy code is *fine*.)

But I couldn't leave PS5.1 and PS7 with different levels of support. I spent some time in September building conditional checks that would use different .NETty stuff (that I honestly don't understand) if Locksmith was used in PS7. It worked great, so we included the feature in 2024.10. 

Shortly after releasing [Locksmith 2024.10](https://github.com/TrimarcJake/Locksmith/releases/tag/v2024.10), I was cleaning up branches (a clean repo is a happy repo), and saw the `add-ps7-support-to-esc8-detections` branch showing as active. I thought to myself "huh... musta forgot to delete after merging." I deleted the branch and moved on with my night.

But I'd effed up. I never actually merged the changes into the `testing` branch which means they didn't make it into the `main` branch which means they didn't make it into the [release packages](https://github.com/TrimarcJake/Locksmith/releases/). I realized my mistake earlier this week and began searching frantically for any machine that contained the branch so I could recreate it and get it into the 2024.11 release.

I couldn't find the branch anywhere.

So this morning, I did what I should've done a while ago and used the Googles. After a little digging, I found [a GitHub community thread](https://github.com/orgs/community/discussions/55884) which gave me just enough information to figure this out.

I restored the branch, then YOLO merged it into `testing` without review because it had already been reviewed. Look for it in 2024.11!

## tl;dr

1. Visit the GitHub repo in question and click the "Activity" icon:![Screenshot 2024-10-26 at 8.41.54 AM.png]({{ site.baseurl}}/images/Screenshot 2024-10-26 at 8.41.54 AM.png)
2. Find an entry in the activity log title "Deleted branch" that mentions the branch you deleted by mistake. Click the three dot menu `...` at the right end of the "Deleted branch" activity and choose "Restore Branch":![Screenshot 2024-10-26 at 8.50.18 AM.png]({{ site.baseurl}}/images/Screenshot 2024-10-26 at 8.50.18 AM.png)
3. Wait a few minutes.
4. Breathe a sigh of relief!

If this guide helps you restore some work you thought you deleted, please reach out to me at [jake@dotdot.horse](mailto:jake@dotdot.horse)!