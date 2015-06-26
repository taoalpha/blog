require "jieba_rb"
require "json"
module Jekyll
  class SearchPage < Page
    def initialize(site, base, dir,h,l)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'search.html')
      self.data['title'] = "Internal Search"
      self.data['index'] = h.to_json
      self.data['worddict'] = l.join(",")
    end
  end
  class SearchGenerator< Generator
    safe true
    def generate(site)
      if site.layouts.key? 'search'
        dir = site.config['search_dir'] || 'search'
        write_search_index(site, File.join(dir, ''))
      end
    end
    def write_search_index(site, dir)
      h = Hash.new
      po = Hash.new
      tlist = []
      keyword = JiebaRb::Keyword.new
      site.posts.each do |post|
        alist = []
        keywords_weights = keyword.extract post.content,45
        keywords_weights.each{|k,v|
          alist.push(k.downcase)
        }
        postdata = Hash.new
        postdata['post_id'] = post.id
        postdata['post_url'] = post.url
        postdata['post_title'] = post.title
        if post["language"] == "en"
          postdata['post_content'] = post.content[0...400].gsub!(/<(.*?)>?|{%|%}|\s|\n|([#]+)|\t/) {" "}
        else
          postdata['post_content'] = post.content[0...200].gsub!(/<(.*?)>?|{%|%}|\s|\n|([#]+)|\t/) {" "}
        end
        postdata['post_author'] = post["author"]
        postdata['post_category'] = post.categories
        postdata['post_tags'] = post.tags
        postdata['post_date'] = post.date
        h[post.url] = alist.uniq
        po[post.url] = postdata
        tlist = tlist | alist.uniq
      end

      nh = Hash.new
      tlist.each{|k|
        klist = []
        h.each{|k2,v|
          if v.include? k
            klist.push(po[k2])
          end
        }
        nh[k] = klist
      }

      index = SearchPage.new(site, site.source, dir, nh, tlist)
      index.dir = dir
      index.render(site.layouts, site.site_payload)
      index.write(site.dest)
      site.pages << index
    end
  end

end
