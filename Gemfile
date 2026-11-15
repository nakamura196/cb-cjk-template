# frozen_string_literal: true

source 'https://rubygems.org'

# needed for Jekyll
gem 'jekyll'
gem 'webrick'
gem 'logger'
gem 'base64'
gem 'ostruct'

# needed for Rake tasks
gem 'rake'
gem 'csv'
gem 'fileutils'
gem 'mini_magick'
unless Gem.win_platform?
  gem 'image_optim'
  gem 'image_optim_pack'
end

# CJK search: index and runtime at build time (cjk-search_cb-add-on)
group :jekyll_plugins do
  gem 'cjk_index', '~> 1.1', require: 'cjk_index/jekyll'
end

# static IIIF: manifests at build time (static-iiif_cb-add-on)
group :jekyll_plugins do
  gem 'static_iiif', git: 'https://github.com/nakamura196/static_iiif.git', tag: 'v0.5.3', require: 'static_iiif/jekyll'
end
