module Jekyll
  class CategoryPage < Page
    def initialize(site, base, dir, category)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'home.html')
      self.data['category'] = category
      self.data['title'] = "#{category}"
      self.data['pname'] = "#{category}"
    end
  end
  class CategoryGenerator < Generator
    safe true
    def generate(site)
      if site.layouts.key? 'home'
        dir = site.config['cate_dir'] || ''
        site.categories.keys.each do |category|
          if category != "blog"
            write_category_index(site, File.join(dir, category), category)
            #write_category_index(site, File.join(dir, category.split.map(&:capitalize).join("-")), category.split.map(&:capitalize).join("-"))
          end
        end
      end
    end
    def write_category_index(site, dir, category)
      category_posts = site.posts.find_all {|post| post.categories.include?(category)}.sort_by {|post| -post.date.to_f}
      num_pages = CategoryPager.calculate_pages(category_posts, site.config['paginate'].to_i)
      (1..num_pages).each do |page|
        pager = CategoryPager.new(site, page, category_posts, category, num_pages)
        index = CategoryPage.new(site, site.source, dir, category)
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

  class CategoryPager < Jekyll::Paginate::Pager 
    attr_reader :category

    def initialize(site, page, all_posts, category, num_pages = nil)
      @category = category
      super site, page, all_posts, num_pages
    end

    alias_method :original_to_liquid, :to_liquid

    def to_liquid
      liquid = original_to_liquid
      liquid['category'] = @category
      liquid
    end
  end

end
