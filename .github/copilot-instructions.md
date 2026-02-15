# Project Guidelines

This is a Jekyll blog deployed on GitHub Pages, authored in Obsidian. Site lives at `jakehildreth.github.io/blog`.

## Architecture

- **Theme:** `minima ~> 2.5` gem with custom overrides in `assets/main.scss`. Variables are set before `@import "minima"` to override defaults.
- **Layout hierarchy:** `base.html` → `home.html`, `post.html`, `page.html`. The `404.html` uses minima's built-in `default` layout.
- **Includes:** `header.html`, `footer.html`, and `head.html` are overridden locally. `head.html` adds favicon links. Footer contains a Matomo image-pixel tracker.
- **Dark mode:** Automatic via `prefers-color-scheme: dark` in `assets/main.scss`.
- **Home page:** Posts are grouped by year with `<h2 class="year-heading">` headings.
- **Post meta:** Reading time is calculated in `post.html` via Liquid (`content | number_of_words / 200`).
- **Authoring:** Posts are written in Obsidian (workspace is inside an iCloud Obsidian vault). Images are often pasted directly via Obsidian.

## Build and Test

```sh
bundle install
bundle exec jekyll serve --baseurl /blog
```

Deployed via the `github-pages` gem (~> 231). The raw `jekyll` gem is commented out in the Gemfile.

## Post Conventions

- **Filename:** `YYYY-MM-DD-Title With Spaces.md` (spaces, not hyphens in title; special chars like `!`, `?`, `…` are common)
- **Front matter (required):**
  ```yaml
  ---
  title: "Post Title"
  creation_date: 2025-12-21
  modified_date: 2025-12-29
  ---
  ```
  - No `layout` key — posts default to `post` layout via minima.
  - No `date` key — date comes from the filename.
  - No `categories` or `tags` — the blog does not use taxonomy.
  - `creation_date` / `modified_date` use ISO format (`YYYY-MM-DD`). Older posts have inconsistent date formats (`June 24, 2023`).
- **Drafts** in `_drafts/` also include dates in filenames (non-standard but consistent here).

## Images

- All images live in a **flat `/images/` directory** (no subdirectories).
- Reference images using: `![Alt text]({{ site.baseurl }}/images/filename.png)`
- URL-encode spaces in filenames: `{{ site.baseurl }}/images/Pasted%20image%2020250412090530.png`
- Common naming patterns: `Pasted image YYYYMMDDHHMMSS.png` (Obsidian paste), `Screenshot YYYY-MM-DD at H.MM.SS AM.png`, or descriptive names.
- Kramdown image size classes: `{: .half}` (50% width), `{: .small}` (300px max). Apply on the line after the image.

## Markdown Style

- Code blocks: fenced with triple backticks + language identifier (`powershell`, `yaml`, `ruby`)
- Kramdown features: `{:toc}` for table of contents, `[^1]` footnotes
- Emoji used liberally inline (🤷, 😅, 💙, etc.)
- `<sub>` HTML tags for image source attribution
- Unordered lists use both `*` and `-`; headings range from `##` to `#####` within posts

## Known Quirks

- `404.html` uses `layout: default` (from minima gem), while all other local layouts use `base.html`.
- Favicon files (`favicon-32x32.png`, `favicon-16x16.png`, `apple-touch-icon.png`) are referenced in `head.html` but must be placed in the site root manually.
