module Jekyll
  require 'json'
  class JSONPost < Page; end

  class JSONGenerator < Generator
    safe true
    def generate(site)
      dir = site.config['api_dir'] || 'api'
      ensure_directory(dir)
      generate_latest(site, dir)
    end
    def generate_latest(site, dir)
      latest_posts = []
      site.posts.reverse.take(5).each do |post|
        post_hash = post.to_liquid.keep_if { |k, _| ['url', 'title', 'created_at', 'author'].include? k }
        if post["language"] == "en"
          post_hash['summary'] = post.content[0...400].gsub!(/{%|%}|\s|\n|([#]+)|\t/) {" "}+"..."
        else
          post_hash['summary'] = post.content[0...200].gsub!(/{%|%}|\s|\n|([#]+)|\t/) {" "}+"..."
        end
        latest_posts.push(post_hash)
      end
      write_to_json(site, dir, latest_posts, 'latest.json')
    end
    def write_to_json(site, dir, data, name)
      File.open("#{dir}/#{name}", 'w') { |f| f.write(data.to_json) }
      site.pages << Jekyll::JSONPost.new(site, site.source, dir, name)
    end
    def ensure_directory(path)
      FileUtils.mkdir_p(path)
    end
  end
end
