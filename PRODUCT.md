# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Identity/AD CS practitioners and the PowerShell community, equally weighted. The first group fights Active Directory and certificate services daily and overlaps with the Locksmith/BlueTuxedo/PowerPUG! user base. The second builds scripts and tools and forms Jake's conference-talk audience. Both are technical readers who value working detail over polish.

## Product Purpose

Jake Hildreth's personal blog ("...horse?", jakehildreth.github.io/blog). Its job: teach practical lessons and share first-person war stories from ~25 years in IT — PowerShell, Active Directory, AD CS security, tooling. Success means a practitioner reads a post and can do the thing afterward; secondary value is a record of Jake's speaking and projects. Explicitly not a marketing surface: personality-forward, war stories allowed to stay rough.

## Positioning

First-person practitioner writing from someone who builds the tools he writes about (Locksmith, BlueTuxedo, PowerPUG!, Stepper, ADCSGoat, ESCalator) and presents them at conferences (PSConfEU, HIP, Blue Team Con, CodeMash, Wild West Hackin' Fest). Posts carry the specificity of real engagements and real code — a neighboring content-mill security blog could not truthfully copy it.

## Operating Context

Posts are authored in Obsidian (this directory is an iCloud-synced Obsidian vault) and built with Jekyll. Published on GitHub Pages via the `github-pages` gem. Speaking schedule and bio live on dedicated pages (`speaking.md`, `about.md`). Drafts in `_drafts/`.

## Capabilities and Constraints

- Jekyll 4.x, minima 2.5 theme with substantial custom overrides: `_layouts/` (base, home, page, post), `_includes/` (head, header w/ dark-mode toggle, footer), `assets/main.scss` (~600 lines of custom styling).
- GitHub Pages gem `~231` constrains plugins to the GitHub Pages allowlist (currently only `jekyll-feed`).
- Kramdown conventions in use: `{: .half}` / `{: .small}` image sizing, `{:toc}` table of contents.
- Custom code-fence languages for ASCII art: `art`, `text`, `ascii`, `plaintext` get line-height 1.0.
- Dark-mode toggle exists in the header (sun/moon button).
- Undecided: whether the "...horse?" title and dotdot.horse email are load-bearing brand or legacy jokes open to change. User flagged no binding constraints during init.

## Brand Commitments

Name: Jake Hildreth. Site title: "...horse?" (unconfirmed whether binding — see above). Voice across 50 posts: terse, funny, self-deprecating, anti-cargo-cult; technical depth without gatekeeping ("PKI Unlocked: A No-Math Primer"). No logo system or formal identity assets beyond the headshot (`images/NewCropped200x200.png`).

## Evidence on Hand

- 50 published posts in `_posts/` (June 2023 – June 2026), 3 drafts in `_drafts/`.
- Full speaking history with abstracts in `speaking.md`.
- Bio and headshot in `about.md` + `images/`.
- No testimonials, press logos, analytics claims, or client names. Future work must not fabricate these.

## Product Principles

1. Teach the thing, not the brand — a reader should leave able to act.
2. War stories over thought leadership — real engagements, real scars, real code.
3. No gatekeeping — deep topics explained without assumed background ("No math, no crypto proofs").
4. Personality is a feature — the voice stays funny and human; polish never sanded off at the cost of sounding like everyone else.
