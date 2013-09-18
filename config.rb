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
  activate :minify_javascript
  activate :relative_assets
  activate :asset_host
  activate :asset_hash
  activate :gzip

  set :asset_host, ENV["ASSET_HOST"]
end

helpers do
  def markdown(text)
    Tilt["markdown"].new do
      text
    end.render(scope = self)
  end
end

require File.join(File.dirname(__FILE__), "source/lib", "sass_extensions.rb")
