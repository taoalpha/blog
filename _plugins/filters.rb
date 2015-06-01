module Jekyll
  module CustomizeFilter
    def uniq(tags)
      tags.uniq!
    end

    def uniq_i(tags)
      tags.map{|x| x.split.map(&:capitalize).join(' ')}.uniq
    end

    def join_tags(tags)
        tags.map{|x| x.split.join('-')}
    end

  end
end

Liquid::Template.register_filter(Jekyll::CustomizeFilter)
