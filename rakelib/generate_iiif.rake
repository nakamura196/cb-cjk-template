# frozen_string_literal: true

###############################################################################
# TASK: generate_iiif   (static-iiif_cb-add-on)
#
# Optional. Makes IIIF Image API level 0 files for the images in "objects/"
# that are listed in the metadata CSV's object_location column:
# a few fixed sizes of each image, and tiles for images larger than 4000 px on
# the long side, in objects/iiif/3/<name>/. Viewers can then zoom into large
# images without an image server. Without this task the manifests point at the
# image files themselves, which is enough for ordinary photographs.
#
# Provided by the static_iiif gem (https://github.com/nakamura196/static_iiif);
# needs the libvips command-line tools (e.g. `brew install vips`,
# `apt-get install libvips-tools`).
#
# Sizes: 90 and 200 px wide are the thumbnails Universal Viewer asks for;
# 256 and 1024 for other viewers.
#
# Usage:  rake generate_iiif
#         rake "generate_iiif[objects,objects/iiif/3,90;200;256;1024,4000,512,false]"
#         (input_dir, output_dir, sizes, tile_threshold (0 = never), tile_size, force)
###############################################################################

begin
  require 'static_iiif/rake_task'

  StaticIIIF::RakeTask.new(:generate_iiif) do |t|
    t.sizes = [90, 200, 256, 1024]
  end
rescue LoadError
  desc 'Make IIIF level 0 image files (needs the static_iiif gem in the Gemfile)'
  task :generate_iiif do
    abort 'generate_iiif: add the static_iiif gem to your Gemfile and run `bundle install` (see the add-on README).'
  end
end
