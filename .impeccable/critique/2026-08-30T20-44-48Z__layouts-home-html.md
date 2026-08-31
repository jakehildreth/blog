---
target: home page (_layouts/home.html)
total_score: 26
max_score: 36
na_heuristics: 10
p0_count: 0
p1_count: 3
timestamp: 2026-08-30T20-44-48Z
slug: layouts-home-html
---
# Design Critique: "...horse?" home page + reading experience

## Design Health Score: 26/36 (H10 n/a) — Good (72%)

| # | Heuristic | Score | Key Issue |
|---|-----------|-------|-----------|
| 1 | Visibility of System Status | 2 | Theme toggle exposes no state (aria-pressed absent) |
| 2 | Match System / Real World | 3 | Chrome jargon: "...horse?", "PS + AD + AD CS + MVP" undecoded |
| 3 | User Control and Freedom | 3 | No pagination/collapse on 49-post scroll |
| 4 | Consistency and Standards | 3 | Stock 404 with ":("; inconsistent date formats |
| 5 | Error Prevention | 4 | Static read surface |
| 6 | Recognition Rather Than Recall | 2 | Excerpts silently broken (minima: nesting bug) |
| 7 | Flexibility and Efficiency | 1 | No search/tags/series/prev-next/pagination |
| 8 | Aesthetic and Minimalist | 4 | Core strength |
| 9 | Error Recovery | 3 | Stock 404 copy, no links |
| 10 | Help and Documentation | n/a | Read-mode blog |

## Design Specificity Verdict
PASS — genuinely grounded (ASCII-art code mode, phosphor dark identity with role separation, year-grouped practitioner archive). Caveat: half the identity lives in dark mode; light mode alone is close to disciplined minima. Detector: 0 findings on normative sources (fragment limitation, canary-verified); 7 on stale built site — 6 skipped-heading (REAL, traced to about.md h1→h5, speaking.md h1→h3, 4 posts h1→h3), 1 em-dash (voice, borderline FP). Browser overlays confirmed: no h1 on home, no skip link, logical focus order; geometry findings were baseurl/CSS-404 artifacts (FP).

## Priority Issues
1. [P1] Excerpts silently broken — show_excerpts nested under minima: in _config.yml, read as site.show_excerpts in home.html. Fix: move key to top level; audit excerpt quality (first-paragraph throat-clearing). Command: $impeccable clarify (archive recognition).
2. [P1] Zero wayfinding accelerators — no search/tags/series/prev-next/pagination; sticky TOC ships but posts never emit {:toc}. Fix: prev/next in post.html, series line per archive row, wire or delete TOC; client-side search as P2 follow-up. Command: $impeccable shape (archive wayfinding).
3. [P1] Accessibility last-mile — no skip link, zero :focus-visible rules, ASCII art unreadable to AT, toggle state unexposed, hamburger label unlabeled, inline-code pink 4.23:1. Fix: skip link, focus-visible rule, role=img/aria-label on figlet, aria-pressed on toggle, darken pink ~8%. Command: $impeccable audit (a11y).
4. [P2] No newcomer on-ramp — "...horse?" and tagline never decoded; no start-here path. Fix: welcome line in index.md, decode joke on About, label RSS link. Command: $impeccable clarify (first-visit copy).
5. [P2] 404 off-brand — stock minima, inline styles, ":(", no links. Fix: layout: base, on-brand copy, links to latest+about; ASCII lost-horse. Command: $impeccable delight (error page).

## Persona Red Flags
- Alex: newest-first arrival fast; series queries, search, prev/next, TOC all fail. 49 bare titles, zero accelerators.
- Jordan: unexplained in-joke + acronym soup; About decodes Jake not the title; speaking page has hipconf.com linked on the WWHF entry.
- Sam: no h1 on home, skipped heading levels on about/speaking/4 posts, no skip link, no focus-visible, toggle state invisible, figlet announced character-by-character; contrast excellent except inline-code pink (4.23:1).

## Minor Observations
- index.md ships scaffold comments; {{ content }} renders nothing.
- home.html emits stray </ul> before first <ul>.
- Pager markup dead (jekyll-paginate absent).
- Two analytics trackers (Matomo pixel + Umami) — vestigial or migration?
- Theme toggle buried in mobile hamburger drawer ≤600px.
- Dead Disqus conditional in post.html.
- data-theme="light" never set explicitly in head.html.
- TOC margin-hang fragile if $content-width grows.

## Questions to Consider
- Why is the phosphor personality gated behind an icon-only toggle most light-mode visitors never touch?
- Why is chronology the only archive axis when the blog's value is series?
- Is "...horse?" a filter or a bug for conference visitors?
- Is the margin TOC a real feature or aspirational CSS?
- What do two analytics trackers say on a blog that teaches attack-surface reduction?
