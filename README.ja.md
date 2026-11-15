# cb-cjk-template

[English README (README.md)](README.md)

[CollectionBuilder-CSV](https://github.com/CollectionBuilder/collectionbuilder-csv) に **CJK Search（日中韓検索）**・**Static IIIF（静的 IIIF マニフェスト＆タイル生成）**・**Museum Theme（モダン／ミュージアムテーマ＆ダークモード）** の 3 つのアドオンと初期設定をあらかじめ組み込んだテンプレートです。

4 つのリポジトリを clone して 8 つのファイルを手で書き換える代わりに、このページ右上の緑色の **「Use this template」** ボタンを押すだけで、すぐに自分の CSV と画像を入れてサイトを作れます。

---

## 使い方（3 ステップ）

1. **リポジトリを作る**
   このページ右上の **「Use this template」→「Create a new repository」** を押して新しいリポジトリ（例: `my-collection`）を作り、手元に clone します。
   ```sh
   git clone https://github.com/<あなたのアカウント>/my-collection.git
   cd my-collection
   ```

2. **データを置く（ウォークスルーの 0-2 節と同じ）**
   - `_data/` にメタデータの CSV を置き、`_config.yml` の `metadata:` にファイル名（拡張子なし）を書きます。
   - 手元に画像がある場合は `objects/`（と `objects/small/`、`objects/thumbs/`）に置き、`_data/theme.yml` の `featured-image:` を設定します。
   - [cb-ja-demo](https://github.com/nakamura196/cb-ja-demo) のサンプルデータ（60 資料・69 行）で試す場合:
     ```sh
     git clone https://github.com/nakamura196/cb-ja-demo.git ../cb-ja-demo
     cp ../cb-ja-demo/_data/utokyo-agri.csv _data/
     cp ../cb-ja-demo/_data/config-*.csv _data/
     cp ../cb-ja-demo/objects/local_*.jpg objects/
     cp ../cb-ja-demo/objects/small/local_* objects/small/
     cp ../cb-ja-demo/objects/thumbs/local_* objects/thumbs/
     ```
     あわせて `_config.yml` の `metadata: utokyo-agri`、`_data/theme.yml` の `featured-image: local_chokanzu` に書き換えます。

3. **手元で動かす・GitHub Pages で公開する**
   - **手元で確認する**（Ruby 3.1 以上）:
     ```sh
     bundle install
     bundle exec jekyll s
     ```
     `http://localhost:4000/` を開くと、CJK 検索・Universal Viewer 表示・モダンテーマ（ダークモード切替・グリッド／リスト切替）が最初から動きます。
   - **大きい画像の IIIF Level 0 タイルを作る（任意、要 `vips`）**:
     ```sh
     bundle exec rake generate_iiif
     ```
     メタデータ CSV の `object_location` に書かれた手元画像だけを処理し、テンプレートの英語デモ画像は自動でスキップします。
   - **GitHub Pages で公開する**:
     1. `_config.yml` の `url`（`https://<あなたのアカウント>.github.io`）と `baseurl`（`/my-collection`）を設定します。
     2. GitHub リポジトリの **Settings → Pages** で **Source** を **GitHub Actions** にします。
     3. コミットして `main` に push すると、同梱済みの `.github/workflows/pages.yml` が自動でビルド・公開します。

---

## あらかじめ組み込まれているもの

本家の [CollectionBuilder/collectionbuilder-csv](https://github.com/CollectionBuilder/collectionbuilder-csv) に対して、[`build-template.zsh`](https://github.com/nakamura196/cb-ja-demo/blob/main/scripts/build-template.zsh) で次の 3 アドオンと 4 つの初期設定を適用しています。

1. **[cjk-search_cb-add-on](https://github.com/nakamura196/cjk-search_cb-add-on)**（[`cjk_index`](https://rubygems.org/gems/cjk_index) gem）
   - ビルド時に `_data/config-search.csv` から日中韓の 2 文字 N-gram（bigram）索引を生成します。
   - 旧字・新字（`圖` / `図`）、ひらがな・カタカナ、繁体字・簡体字（`實錄` / `实录`、`variants: [ja, zh]`）を同一視して検索できます。
2. **[static-iiif_cb-add-on](https://github.com/nakamura196/static-iiif_cb-add-on)**（[`static_iiif`](https://github.com/nakamura196/static_iiif) gem）
   - メタデータ CSV からビルド時に IIIF Presentation 3 マニフェスト（`/iiif/3/<objectid>/manifest.json`）を生成し、`display_template: iiif` で Universal Viewer と Mirador ボタンを表示します。
3. **[museum-theme_cb-add-on](https://github.com/nakamura196/museum-theme_cb-add-on)**
   - `_data/theme.yml` の `theme-style: modern`（または `museum`）と `color-mode-toggle: true`、一覧・検索のグリッド／リスト切替、任意のトップページ用レイアウト `home-museum` を備えています。
4. **つまずきを防ぐ初期設定**
   - `.gitignore` から `objects/` を除外済み（手元の画像や IIIF タイルがそのまま `git add` できます）。
   - `_config.yml` に `sass: silence_deprecations: [if-function]` を設定済み（Sass の警告でビルドログが埋まりません）。
   - 開発時（`jekyll s`）のみ `<meta name="referrer" content="no-referrer">` を出力（`localhost` からの Referer を拒否する外部 IIIF サーバの画像もローカルで表示できます）。
   - `.github/workflows/pages.yml`（Actions のコミット SHA 固定・`JEKYLL_ENV: production`）を同梱済み。

---

## ライセンス

- コード・テンプレート: [MIT License](LICENSE)
- 文書: [CC BY-SA 4.0](http://creativecommons.org/licenses/by-sa/4.0/)
