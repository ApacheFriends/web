class DownloadBuilder < Middleman::Extension
  option :source, "./downloads.yml", "Source manifest (.yml)"

  DISPLAY_ORDER = %w[windows browsers linux apple appleVM]
  FRIENDLY_NAMES = {
    "apple" => "OS X",
    "appleVM" => "OS X (VM)",
  }

  def initialize(app, options_hash={}, &block)
    super

    begin
      @downloads = YAML.load_file(options.source)
    rescue Exception => e
      raise "could not load downloads manifest: #{e.message}"
    end

    @downloads.each do |os, releases|
      releases.each_with_index do |download, i|
        @downloads[os][i]["id"] = Digest::MD5.hexdigest(download.values.join)[0..9]
      end
    end

    # sort hash
    @downloads = Hash[@downloads.sort_by{|os,r| DISPLAY_ORDER.index(os) }]

    app.set :downloads, @downloads
  end
end

::Middleman::Extensions.register(:download_builder, DownloadBuilder)
