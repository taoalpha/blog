require 'jieba_rb'
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

    def keywords(tags)
      keyword = JiebaRb::Keyword.new
      alist = []
      keywords_weights = keyword.extract tags,25
      keywords_weights.each{|k,v|
        alist.push(k)
      }
      alist.reverse!
    end

  end
end

Liquid::Template.register_filter(Jekyll::CustomizeFilter)
