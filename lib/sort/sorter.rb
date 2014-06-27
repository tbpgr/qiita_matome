# encoding: utf-8
require 'sort/sort_consts'

module QiitaMatome
  #  QiitaMatome::Sort
  module Sort
    # QiitaMatome::Sort::Sorter
    class Sorter
      attr_reader :articles, :sort_type
      ARTICLE_TYPE_ERROR = "invalid argument type '%s'. article must be Array"

      def initialize(articles, sort_type = Consts::UPDATE_DATE_DESC)
        validate_articles(articles)
        @articles = articles
        @sort_type = sort_type
      end

      private

      def validate_articles(articles)
        return if articles.is_a?(Array)
        fail ArgumentError, format(ARTICLE_TYPE_ERROR, articles.class)
      end
    end
  end
end
