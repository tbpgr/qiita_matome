# encoding: utf-8
require 'sort/sort_consts'

module QiitaMatome
  #  QiitaMatome::Sort
  module Sort
    # QiitaMatome::Sort::Sorter
    class Sorter
      attr_reader :articles, :sort_type
      ARTICLES_TYPE_ERROR = "invalid argument type '%s'. article must be Array"
      ARTICLE_TYPE_ERROR = "invalid argument type '%s'. article must be Article"

      def initialize(articles, sort_type = Consts::UPDATE_DATE_DESC)
        validate_articles(articles)
        validate_article(articles)
        @articles = articles
        @sort_type = sort_type
      end

      private

      def validate_articles(articles)
        return if articles.is_a?(Array)
        fail ArgumentError, format(ARTICLES_TYPE_ERROR, articles.class)
      end

      def validate_article(articles)
        return if articles.empty?
        articles.each do |article|
          next if article.is_a?(Article)
          fail ArgumentError, format(ARTICLE_TYPE_ERROR, article.class)
        end
      end
    end
  end
end
