###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

APP = (ENV['app'] || ENV['APP'] || :apachefriends).to_sym
PLATFORM = (ENV['platform'] || ENV['PLATFORM'] || :common).to_sym

# if application is XAMPP, use different source and build directory so
# it is easier to build both sites independently

if APP == :xampp
  set :source, "source-xampp-#{PLATFORM}"
  set :build_dir, "build-xampp-#{PLATFORM}"
else
  set :source, "source"
  set :build_dir, "build"
end

activate :i18n, :mount_at_root => :en, :langs => Dir["locales/*.po"].map{|f| f.match(/locales\/(.*)\.po/)[1]}.sort
I18n::Backend::Simple.include(I18n::Backend::Gettext)
I18n.load_path += Dir["locales/*.po"]
I18n.default_separator = "|"

# for building download page
# based on .yml manifest
require 'download_builder'
activate :download_builder, :source => "./downloads.yml"

# set permissions on file downloads
after_build do |builder|
  builder.run 'chmod 444 build/downloads/*' if APP != :xampp
end

#set :asciidoc, asciidoc.merge( header_footer: true )
set :asciidoc_attributes, ["-a toc", "imagesdir=./images", "docdir=./#{source}/docs", "icons=font"]

set :fb_app_id, 277385395761685

if APP == :xampp
  DOMAIN = development? ? "http://localhost:4567" : "http://localhost"
  set :http_prefix, ENV['http_prefix'] || "/dashboard"
else
  DOMAIN = development? ? "http://localhost:4567" : "https://www.apachefriends.org"
end

FORUM_DOMAIN = "https://community.apachefriends.org/f"

set :domain, DOMAIN
set :forum_domain, FORUM_DOMAIN
set :forum_post_count, 2

require 'documentation'
activate :documentation, :source => "#{source}/docs"

FORUM_FEEDS = {
  :en => FORUM_DOMAIN + '/feed.php?f=16',
  :de => FORUM_DOMAIN + '/feed.php?f=4'
}

STACKS = {
  "WordPress" => "Blog",
}

set :xampp_stacks, STACKS

LOCALIZED_PATHS = Dir.glob(File.join(source, "localizable/*.html.erb")).map{|f| File.dirname(f).gsub("source/localizable", "") + File.basename(f, ".erb")}

helpers do
  def retina_image_tag(source, options = {})
    options[:suffix] ||= '@2x'
    unless options[:width] || options[:height]
      logger.warn "retina_image_tag used without explicit width or height (#{source})"
    end
    retina_source = source.gsub(/(\.\w+)$/) {|ext| options.delete(:suffix) + ext}
    image_tag(source, options.merge(:"data-2x" => image_path(retina_source) ))
  end

  def page_url
    URI.join(DOMAIN, current_page.url)
  end

  def download_link_to(name = nil, options = nil, html_options = {}, &block)
    raise if block_given?
    html_options.merge!(:"data-delayed-href" => localized_path("/download_success.html"), :target => "_blank")
    link_to(name, options, html_options, &block)
  end

  def localized_path(absolute_path, locale=nil)
    locale        ||= I18n.locale
    absolute_path.gsub!(/^\//, '')
    absolute_path = "#{absolute_path}index.html" if absolute_path =~ /\/$/
    absolute_path = locale == :en ? absolute_path : "#{locale}/#{absolute_path}"
    return http_prefix.gsub(/\/$/,'') + '/' + absolute_path
  end

  def localized_link_to(name, absolute_path, locale=nil)
    link_to I18n.t(name), localized_path(absolute_path, locale)
  end

  def af_localized_path(absolute_path, locale=nil)
    if APP == :xampp
      return "https://www.apachefriends.org#{absolute_path}"
    else
      localized_path absolute_path, locale
    end
  end

  def af_localized_link_to(name, absolute_path, locale=nil)
    if APP == :xampp
      link_to I18n.t(name), "https://www.apachefriends.org#{absolute_path}"
    else
      localized_link_to name, absolute_path, locale
    end
  end

  def af_link_to name, absolute_path
    if APP == :xampp
      link_to name, "https://www.apachefriends.org#{absolute_path}"
    else
      link_to name, absolute_path
    end
  end

  def link_to_docs name, path
    link_to name, http_prefix.gsub(/\/$/,'') + '/docs/' + path
  end

  def is_xampp?
    return APP == :xampp
  end

  def is_xampp_platform? platform
    return APP == :xampp && PLATFORM == platform.to_sym
  end

  def xampp_platform
    return PLATFORM
  end

  def xampp_platform_name
    return {
      :osx => "OS X",
      :windows => "Windows",
      :linux => "Linux"
    }[PLATFORM]
  end

  def forum_feed_url(locale = nil)
    locale ||= I18n.locale
    FORUM_FEEDS[locale.to_sym]
  end

  def path_is_localized?(path = nil)
    p = (path || current_page.path).gsub(/^(#{I18n.available_locales.join('|')})\//, '')
    LOCALIZED_PATHS.include?(p)
  end

  def rtl_language?
    %w{ur}.include?(I18n.locale.to_s)
  end
end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

set :index_file, 'disabled.html' # to allow links to index.html urls

# Bower patch
sprockets.append_path File.join(root, 'bower_components')

if APP == :xampp
else
  # Blogging plugin
  activate :blog do |blog|
    # set options on blog
    blog.prefix = "blog"
    blog.sources = "{title}.html"
    blog.permalink = "{title}.html"
    blog.default_extension = ".md"
    blog.layout = "blog_layout"
  end

  page "/feed.xml", :layout => false
  page "/sitemap.xml", :layout => false

  set :deploy_target, (ENV['TARGET'].try(:downcase) || 'staging')

  # Build-specific configuration
  configure :build do
    # For example, change the Compass output style for deployment
    # activate :minify_css

    # Minify Javascript on build
    # activate :minify_javascript

    # Enable cache buster
    activate :asset_hash

    if deploy_target == 'production'
      activate :asset_host
      set :asset_host, "//d16zszyyqlzz6z.cloudfront.net"
    end

    # Use relative URLs
    # activate :relative_assets

    # Or use a different image path
    # set :http_prefix, "/Content/images/"
  end

  DEPLOYMENT_PATHS = {
    'staging' => "/opt/bitnami/apps/staging-apachefriends-web/htdocs",
    'production' => "/opt/bitnami/apps/apachefriends-web/htdocs"
  }

  activate :deploy do |deploy|
    deploy.build_before = true
    deploy.method = :rsync
    deploy.host   = "10.10.32.40"
    deploy.path   = DEPLOYMENT_PATHS[deploy_target]
    deploy.user   = "bitnami"
    # deploy.clean = true # remove orphaned files on remote host, default: false
    # deploy.flags = "-rltgoDvzO --no-p --del -e" # add custom flags, default: -avze
  end
end
