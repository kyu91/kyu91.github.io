module Jekyll
  class RSSGenerator < Generator
    safe true
    priority :low

    def generate(site)
      site.pages << RSSPage.new(site, site.source, '', 'rss.xml')
    end
  end

  class RSSPage < Page
    def initialize(site, base, dir, name)
      @site = site
      @base = base
      @dir = dir
      @name = name

      self.process(name)
      self.data = {}
      self.content = generate_rss_content
    end

    def generate_rss_content
      rss_content = <<~RSS
        <?xml version="1.0" encoding="UTF-8"?>
        <rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
          <channel>
            <title>#{@site.config['title']}</title>
            <description>#{@site.config['description']}</description>
            <link>#{@site.config['url']}</link>
            <atom:link href="#{@site.config['url']}/rss.xml" rel="self" type="application/rss+xml"/>
            <language>#{@site.config['lang']}</language>
            <lastBuildDate>#{Time.now.rfc822}</lastBuildDate>
      RSS

      @site.posts.docs.each do |post|
        rss_content += <<~ITEM
            <item>
              <title>#{post.data['title']}</title>
              <description>#{post.excerpt || post.content[0..200]}...</description>
              <link>#{@site.config['url']}#{post.url}</link>
              <guid>#{@site.config['url']}#{post.url}</guid>
              <pubDate>#{post.date.rfc822}</pubDate>
            </item>
        ITEM
      end

      rss_content += <<~RSS
          </channel>
        </rss>
      RSS

      rss_content
    end
  end
end
