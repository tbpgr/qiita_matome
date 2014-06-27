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
        @articles = articles
        @sort_type = sort_type
      end
    end
  end
end
