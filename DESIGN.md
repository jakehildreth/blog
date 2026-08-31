---
name: "...horse?"
description: "First-person practitioner writing on PowerShell, AD, and AD CS security."
colors:
  primary: "#1a6dd4"
  horse-blue: "#1a6dd4"
  ink: "#2d2d2d"
  heading-ink: "#1a1a2e"
  paper: "#fdfdfd"
  mid-grey: "#6b7280"
  light-grey: "#e5e7eb"
  dark-grey: "#374151"
  code-bg: "#f6f8fa"
  code-border: "#e1e4e8"
  inline-code-pink: "#d63384"
  quote-bg: "#f0f6ff"
  terminal-black: "#121212"
  terminal-panel: "#1a1a1a"
  terminal-code-bg: "#1e1e1e"
  terminal-border: "#333333"
  terminal-text: "#cccccc"
  terminal-heading: "#e5e5e5"
  phosphor-coral: "#ff8a80"
  magenta-glow: "#ff7bd9"
  soft-magenta: "#ff9de5"
  pale-coral: "#ffab9d"
typography:
  body:
    fontFamily: "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif"
    fontSize: "17px"
    fontWeight: 400
    lineHeight: 1.7
  headline:
    fontFamily: "'Berkeley Mono', 'SF Mono', 'Cascadia Code', Menlo, Monaco, Consolas, monospace"
    fontWeight: 700
    lineHeight: 1.2
  title:
    fontFamily: "'Berkeley Mono', 'SF Mono', 'Cascadia Code', Menlo, Monaco, Consolas, monospace"
    fontWeight: 700
    lineHeight: 1.2
  label:
    fontFamily: "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif"
    fontSize: "0.85em"
    fontWeight: 400
    letterSpacing: "0.5px"
    textTransform: "uppercase"
  mono:
    fontFamily: "'Berkeley Mono', 'SF Mono', 'Cascadia Code', Menlo, Monaco, Consolas, monospace"
    fontSize: "85%"
    lineHeight: 1.3
rounded:
  sm: "6px"
  md: "8px"
spacing:
  content-width: "960px"
  section-gap: "1.5em"
  paragraph-gap: "1.3em"
components:
  nav-link:
    textColor: "{colors.ink}"
    typography: "{typography.body}"
  nav-link-hover:
    textColor: "{colors.primary}"
  theme-toggle:
    textColor: "{colors.mid-grey}"
    rounded: "{rounded.sm}"
    padding: "4px 8px"
  theme-toggle-hover:
    textColor: "{colors.primary}"
  toc-panel:
    backgroundColor: "{colors.code-bg}"
    rounded: "{rounded.md}"
    padding: "1.25em 1.25em 1.25em 2.5em"
  inline-code:
    backgroundColor: "{colors.code-bg}"
    textColor: "{colors.inline-code-pink}"
    rounded: "{rounded.sm}"
    padding: "0.2em 0.4em"
    typography: "{typography.mono}"
  code-block:
    backgroundColor: "{colors.code-bg}"
    rounded: "{rounded.md}"
    padding: "16px"
    typography: "{typography.mono}"
  post-image:
    rounded: "{rounded.md}"
---

# Design System: ...horse?

## Overview

**Creative North Star: "The Terminal, Warmed Up"**

The site is a reading instrument for long-form technical writing. Chrome recedes. Words and code carry everything. The light theme is near-white paper with one disciplined blue accent; the dark theme is where the personality lives — headings and accents flip to magenta and coral phosphor on near-black, like a terminal that learned to glow. Typography pairs Berkeley Mono (headings, code — the terminal voice) with Inter (body — the quiet counterweight), both self-hosted, at a generous 17px/1.7 body.

Density is moderate and text-first: a single 960px column, year-grouped post archive, sticky table-of-contents on wide screens. Nothing on the page competes with the content. Components are quiet and functional — hover states are color shifts, not motion events.

**Key Characteristics:**
- Single accent discipline in light mode (one blue, used sparingly)
- Dual identity: reserved light theme vs. phosphor-glow dark theme
- Code as a first-class citizen (mono family, fenced blocks, ASCII-art line-height mode)
- Text-first layouts; imagery appears only inside posts
- No shadows except on post images; depth conveyed by borders and tonal panels

## Colors

The palette is a near-white neutral field with one blue accent in light mode; dark mode swaps the accent family to coral/magenta against near-black.

### Primary
- **Horse Blue** (#1a6dd4): the single light-mode accent. Header top border (4px), links inside post content, blockquote left border, year-heading underline, TOC links, nav/toggle hover states. Never used for large fills.

### Secondary
- **Inline Code Pink** (#d63384): light-mode inline `code` text only — a minima-era survivor kept deliberately. Distinguishes inline code from links at a glance.

### Neutral
- **Paper** (#fdfdfd): light background.
- **Ink** (#2d2d2d): light body text.
- **Heading Ink** (#1a1a2e): light headings, post titles, site title.
- **Mid Grey** (#6b7280): metadata, dates, theme toggle at rest.
- **Light Grey** (#e5e7eb): hairline borders and dividers.
- **Dark Grey** (#374151): year headings, blockquote text.
- **Code Background** (#f6f8fa) with **Code Border** (#e1e4e8): code blocks, TOC panel, table headers.
- **Quote Background** (#f0f6ff): blockquote tint — the only blue-tinted surface.

### Dark Theme
- **Terminal Black** (#121212): dark background.
- **Terminal Panel** (#1a1a1a): header/footer surfaces.
- **Terminal Code BG** (#1e1e1e): code blocks, TOC panel, table headers in dark.
- **Terminal Border** (#333333): all dark hairlines.
- **Terminal Text** (#cccccc) / **Terminal Heading** (#e5e5e5): dark body and h4–h6 headings.
- **Phosphor Coral** (#ff8a80): dark links, year-heading underline, syntax classes.
- **Magenta Glow** (#ff7bd9): dark h1/h2/post titles, header top border, TOC border, blockquote border.
- **Soft Magenta** (#ff9de5): dark h3, site title, inline code text.
- **Pale Coral** (#ffab9d): dark post-list links, hover states.

### Named Rules
**The One Accent Rule.** Light mode has exactly one accent (Horse Blue) and it never fills a surface — it appears only as text color, hairline border, or 4px top stripe. Its rarity is the point.

**The Phosphor Rule.** Dark mode is not an inversion of light mode; it is a different personality. Coral for interactive elements (links), magenta for structure (headings, borders). Never mix the two roles.

## Typography

**Display Font:** Berkeley Mono (self-hosted variable, weights 400/700 + obliques) for all headings, the site title, and code.
**Body Font:** Inter (self-hosted variable 100–900 + italic) at 17px/1.7.
**Label Font:** Inter at 0.85em uppercase for metadata labels.

**Character:** Berkeley Mono's warm, rounded monospace carries the personality — it owns headings and code, so the site's structure itself is typed in the terminal voice. Inter is the quiet counterweight: dense, neutral, highly legible long-form body text that lets the mono do the talking. Self-hosted throughout; no Google Fonts.

### Hierarchy
- **Title** (Berkeley Mono 700, minima default sizes, 1.2): post titles, site title. Site title also gets -0.5px letter-spacing.
- **Headline** (Berkeley Mono 700, 1.2): h1–h6, year headings, post-list links.
- **Body** (Inter 400, 17px, 1.7): long-form reading. Paragraph spacing 1.3em.
- **Label** (Inter 400, 0.85em, +0.5px tracking, uppercase): dates and post metadata.
- **Mono** (Berkeley Mono 400–700, 85% of context size, 1.3): inline code and fenced blocks.

### Named Rules
**The ASCII Art Rule.** Code fenced as `art`, `text`, `ascii`, or `plaintext` renders at line-height 1.0 — ASCII diagrams must survive. This overrides the mono default.

## Layout

Single centered column, 960px max width (`$content-width`), minima breakpoints at 960px (laptop) and 600px (palm). The home page is a year-grouped archive: year headings with a 2px accent underline, post entries separated by hairlines. Post pages are one column of prose with a bordered header.

At ≥1520px the post TOC escapes the flow: it floats right, sticks at top: 2em, and hangs into the right margin (width 220px, margin-right: -282px) — a marginal note, not a sidebar. The breakpoint is set so the box always clears the content column's right edge and stays onscreen. Below 1520px it renders as a boxed "On this page" panel above the content.

## Elevation & Depth

Flat by default. The system uses tonal panels (#f6f8fa / #1e1e1e) and hairline borders instead of shadows. The single exception: images inside posts get a soft ambient shadow (0 2px 8px rgba(0,0,0,0.08); rgba(0,0,0,0.4) in dark) plus an 8px radius — imagery is lifted, chrome is not.

### Shadow Vocabulary
- **Image lift** (`box-shadow: 0 2px 8px rgba(0,0,0,0.08)`): post-content images only, both themes (darkened to 0.4 alpha in dark mode).

### Named Rules
**The Flat Chrome Rule.** No shadows on UI chrome — header, footer, nav, TOC, code blocks, tables. Depth on chrome is conveyed by hairline borders and tonal shifts only. Shadows belong to content imagery.

## Shapes

Gently rounded everywhere: 6px on small elements (inline code, theme toggle), 8px on panels (code blocks, TOC, tables, blockquotes, post images). Blockquotes use an asymmetric radius (0 8px 8px 0) so the 4px accent border reads as a spine. No sharp corners, no pills, no circles beyond the theme-toggle icons.

## Components

There is no button system, no cards, no inputs — this is a reading site. The documented components are the ones that actually exist.

### Navigation
- **Style:** text links in the header, weight 500, Ink color; hover shifts to Horse Blue with no underline. Mobile: minima's checkbox-driven hamburger.
- **Site title:** weight 600, -0.5px tracking, never accent-colored in light mode (Heading Ink); Soft Magenta in dark.

### Theme Toggle
- **Style:** ghost button in the header (6px radius, 1px Light Grey border, Mid Grey icon, 4px 8px padding). Sun icon in light, moon in dark.
- **Hover:** icon and border shift to the theme's accent (Horse Blue light / coral-magenta dark). Persists via localStorage; defaults to `prefers-color-scheme`.

### TOC Panel
- **Style:** tonal panel (Code Background, 8px radius, 1px Code Border) with an injected "On this page" label (weight 700). Links are accent-colored with underline on hover only. Dark mode: border flips to Magenta Glow.

### Code
- **Inline:** Code Background, Inline Code Pink text, 6px radius, 0.2em 0.4em padding. Dark mode: Soft Magenta on Terminal Code BG.
- **Block:** Code Background panel, 8px radius, 16px padding, horizontal scroll, syntax-highlighted (Rouge; dark theme uses a custom coral/magenta palette on Terminal Code BG).

### Blockquote
- **Style:** 4px accent left border (Horse Blue / Magenta Glow), tinted background (Quote Background / Terminal Panel), asymmetric radius, no italics.

### Tables
- **Style:** rounded container (8px, clipped), tonal header row with 2px bottom border, zebra striping. Dark mode: all borders Terminal Border, headers Terminal Code BG.

### Footer
- **Style:** tonal panel (Paper-adjacent #f9fafb / Terminal Panel), hairline top border, RSS subscribe link, author + tagline, social icon row. Hosts the Matomo image tracker and the theme-toggle script.

## Do's and Don'ts

### Do:
- **Do** keep light mode to one accent; add hierarchy with greys and structure, not new hues.
- **Do** preserve the coral/magenta role split in dark mode — coral interactive, magenta structural.
- **Do** use the `art`/`text`/`ascii`/`plaintext` fence classes for ASCII diagrams (line-height 1.0 is load-bearing).
- **Do** size post images with the `{: .half}` and `{: .small}` kramdown classes instead of inline styles.
- **Do** let the TOC marginal note stay in the margin — 220px wide, sticky, hanging past the column on ≥1200px.

### Don't:
- **Don't** add shadows to chrome. Flat surfaces, hairline borders, tonal panels.
- **Don't** introduce a second accent hue in light mode (inline-code pink is grandfathered; nothing else joins it).
- **Don't** use weight 700+ for headings; 500/600 is the ceiling.
- **Don't** add display typography or hero blocks — the site opens with the archive, and that is the design.
- **Don't** break the dark theme's syntax palette (coral/magenta Rouge classes) when touching code styles.
