require 'models/article'

module QiitaMatome
  # QiitaMatome::Articles
  class Articles
    include Enumerable
    attr_accessor :articles
    def initialize(articles = [])
      @articles = articles
    end

    def <<(article)
      @articles << article
    end

    def +(other)
      @articles += other.articles
      self
    end

    def size
      @articles.size
    end

    def each
      @articles.each { |article|yield(article) }
    end

    def filter_by_tag(tag)
      @articles.select { |e|e.tag == tag }
    end
  end
end
