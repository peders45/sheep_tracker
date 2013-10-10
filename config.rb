require "slim"
require "susy"
require "animate-sass"

activate :livereload

set :slim, pretty: true, format: :html5, use_html_safe: true, tabsize: 2

set :css_dir, "stylesheets"
set :js_dir, "javascripts"
set :images_dir, "images"

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :relative_assets
end

require File.join(File.dirname(__FILE__), "source/lib", "sass_extensions.rb")
