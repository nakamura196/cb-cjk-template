# cb-cjk-template

[日本語 README (README.ja.md)](README.ja.md)

A "Built On" [CollectionBuilder-CSV](https://github.com/CollectionBuilder/collectionbuilder-csv) template with **CJK Search**, **Static IIIF**, and **Museum Theme** pre-installed and ready to use out of the box.

Instead of copying three add-on repositories and editing eight template files by hand, click **"Use this template"** once on GitHub and start adding your metadata CSV and images right away.

---

## Quick Start (3 Steps)

1. **Create your repository**
   Click the green **"Use this template" → "Create a new repository"** button at the top of this page, then clone your new repository:
   ```sh
   git clone https://github.com/<your-account>/<your-repo>.git
   cd <your-repo>
   ```

2. **Add your collection data**
   - Put your metadata CSV in `_data/` and set `metadata:` in `_config.yml`.
   - Put local images (if any) in `objects/` (`objects/small/`, `objects/thumbs/`) and set `featured-image:` in `_data/theme.yml`.
   - To try with the 60-item Japanese/Chinese/Korean sample dataset from [cb-ja-demo](https://github.com/nakamura196/cb-ja-demo):
     ```sh
     git clone https://github.com/nakamura196/cb-ja-demo.git ../cb-ja-demo
     cp ../cb-ja-demo/_data/utokyo-agri.csv _data/
     cp ../cb-ja-demo/_data/config-*.csv _data/
     cp ../cb-ja-demo/objects/local_*.jpg objects/
     cp ../cb-ja-demo/objects/small/local_* objects/small/
     cp ../cb-ja-demo/objects/thumbs/local_* objects/thumbs/
     ```
     Then set `metadata: utokyo-agri` in `_config.yml` and `featured-image: local_chokanzu` in `_data/theme.yml`.

3. **Preview locally or publish on GitHub Pages**
   - **Local preview** (requires Ruby 3.1+):
     ```sh
     bundle install
     bundle exec jekyll s
     ```
     Open `http://localhost:4000/`.
   - **Optional IIIF level 0 zoom tiles** for large images in `objects/` (requires `vips`):
     ```sh
     bundle exec rake generate_iiif
     ```
   - **Publish on GitHub Pages**:
     1. In `_config.yml`, set `url: https://<your-account>.github.io` and `baseurl: /<your-repo>`.
     2. In your repository's **Settings → Pages**, set **Source** to **GitHub Actions**.
     3. Commit and push to `main`. `.github/workflows/pages.yml` is already included and will build and deploy the site automatically.

---

## What Is Pre-Installed

This template starts from upstream [CollectionBuilder/collectionbuilder-csv](https://github.com/CollectionBuilder/collectionbuilder-csv) and applies three cb-add-ons plus four setup improvements via [`build-template.zsh`](https://github.com/nakamura196/cb-ja-demo/blob/main/scripts/build-template.zsh):

1. **[cjk-search_cb-add-on](https://github.com/nakamura196/cjk-search_cb-add-on)** ([`cjk_index`](https://rubygems.org/gems/cjk_index) gem)
   - Overlapping 2-character (bigram) search index for Chinese, Japanese, and Korean text, built at Jekyll build time from `_data/config-search.csv`.
   - Matches old/new kanji (`圖` / `図`), hiragana/katakana, and Traditional/Simplified Chinese (`實錄` / `实录`) with `variants: [ja, zh]` in `_config.yml`.
   - `pages/search.md` (`layout: search-cjk`) and `pages/browse.md` (`layout: browse-cjk`) are wired up.
2. **[static-iiif_cb-add-on](https://github.com/nakamura196/static-iiif_cb-add-on)** ([`static_iiif`](https://github.com/nakamura196/static_iiif) gem)
   - Generates IIIF Presentation 3 manifests (`/iiif/3/<objectid>/manifest.json`) at build time from your metadata CSV for single-image and compound items in `objects/`.
   - Includes the `iiif` item layout (`display_template: iiif`) with Universal Viewer and a Mirador button, plus `bundle exec rake generate_iiif` for static IIIF Image API level 0 tiles.
3. **[museum-theme_cb-add-on](https://github.com/nakamura196/museum-theme_cb-add-on)**
   - Two styles (`modern` and `museum`) switched in `_data/theme.yml` (`theme-style: modern`), with a light/dark mode toggle (`color-mode-toggle: true`), a Browse/Search grid/list view toggle, and an optional `home-museum` home page layout.
4. **Pre-configured CB-CSV conveniences**
   - `.gitignore` no longer ignores `objects/`, so your local images and generated IIIF tiles can be committed directly.
   - `sass: silence_deprecations: [if-function]` in `_config.yml` keeps the build log clean on Dart Sass.
   - `<meta name="referrer" content="no-referrer">` in development mode (`jekyll s`) avoids 403 errors from external IIIF servers that reject `http://localhost` referrers.
   - `.github/workflows/pages.yml` with commit-SHA-pinned GitHub Actions and `JEKYLL_ENV: production`.

---

## Rebuilding from Upstream CB-CSV

This repository is generated reproducibly from upstream `CollectionBuilder/collectionbuilder-csv` using [`scripts/build-template.zsh`](https://github.com/nakamura196/cb-ja-demo/blob/main/scripts/build-template.zsh) in `cb-ja-demo`:

```zsh
zsh ../cb-ja-demo/scripts/build-template.zsh --in-place --variants=ja,zh
```

## License

- Template code and add-on files: [MIT License](LICENSE)
- Documentation: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)
- Built on [CollectionBuilder-CSV](https://github.com/CollectionBuilder/collectionbuilder-csv) by University of Idaho Library Digital Initiatives and CDIL.
