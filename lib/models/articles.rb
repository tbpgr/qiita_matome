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
      # print  @articles
      puts "@@@@@@@@@@@@@@@@@"
      puts @articles.class
      puts @articles.first.class
      puts "@@@@@@@@@@@@@@@@@"
      puts
      @articles.select { |e|e.tags.map { |t|t['name'] }.include?(tag) }
    end
  end
end
