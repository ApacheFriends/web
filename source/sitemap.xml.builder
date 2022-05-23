xml.instruct!
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do
  for page in sitemap.resources.find_all{|p| p.source_file.match(/\.html/) }
    next if page.destination_path =~ /(^google[a-z0-9]*|search).html$/
    xml.url do 
      xml.loc "#{domain}/#{page.destination_path}"
      #xml.changefreq "weekly"
      xml.priority "1.0"
    end
  end

  for article in blog.articles
    xml.url do 
      xml.loc "#{domain}#{article.url}"
      #xml.changefreq "weekly"
      xml.priority "0.7"
    end
  end
end
