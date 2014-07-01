require 'models/article'

module QiitaMatome
  # QiitaMatome::Articles
  class Articles
    include Enumerable
    attr_accessor :articles

    def self.exclude_uuid(target_articles, uuids)
      uuids_list = Array(uuids)
      target_articles.delete_if { |e|uuids_list.include?(e.uuid) }
      target_articles
    end

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
      @articles.select { |e|e.tags.map { |t|t['name'] }.include?(tag) }
    end
  end
end
