module Jekyll
  class AuthorIndex < Page
    def initialize(site, base, dir, author)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'authorpage.html')
      self.data['author'] = author
      author_title_prefix = site.config['author_title_prefix'] || 'Posts written by : '
      self.data['title'] = "#{author_title_prefix}#{author}"
      self.data['pname'] = "user/#{author}"
    end
  end
  class AuthorGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'authorpage'
        dir = site.config['author_dir'] || 'user'
        Jekyll.configuration({})['authors'].keys.each do |author|
          write_author_index(site, File.join(dir, author), author)
          #write_author_index(site, File.join(dir, author.split.map(&:capitalize).join("-")), author.split.map(&:capitalize).join("-"))
        end
      end
    end
    def write_author_index(site, dir, author_name)
      author_posts = site.posts.find_all {|post| post['author'] == author_name}.sort_by {|post| -post.date.to_f}
      num_pages = AuthorPager.calculate_pages(author_posts, site.config['paginate'].to_i)
      (1..num_pages).each do |page|
        pager = AuthorPager.new(site, page, author_posts, author_name, num_pages)
        index = AuthorIndex.new(site, site.source, dir, author_name)
        index.pager = pager
        index.dir = dir
        if page != 1
          index.dir = File.join(dir, "page#{page}")
        end
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.pages << index
      end
    end
  end

  class AuthorPager < Jekyll::Paginate::Pager 
    attr_reader :author

    def initialize(site, page, all_posts, author, num_pages = nil)
      @author = author
      super site, page, all_posts, num_pages
    end

    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      liquid = original_to_liquid
      liquid['author'] = @author
      liquid
    end
  end

end
