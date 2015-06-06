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

    def sort_by_array(tags,sArray)
      newObj = {}
      newArray = []
      sArray.each_index do |x|
        newObj[x] = sArray[x]
      end
      newObj.sort_by{|_key, value| value }.each do |x,y|
        newArray.push(tags[x])
      end
      newArray.reverse!
    end

  end
end

Liquid::Template.register_filter(Jekyll::CustomizeFilter)
