# encoding: utf-8
require 'sort/sort_consts'

module QiitaMatome
  #  QiitaMatome::Sort
  module Sort
    # QiitaMatome::Sort::Sorter
    class Sorter
      attr_reader :articles, :sort_type
      # rubocop:disable LineLength
      ARTICLES_CLASS_ERROR = "invalid argument class '%s'. articles must be Array"
      ARTICLE_CLASS_ERROR = "invalid argument class '%s'. article must be Article"
      SORT_TYPE_ERROR = "invalid sort_type '%s'. sort_type must be 'create_date_asc', 'create_date_desc', 'update_date_asc', 'update_date_desc', 'title_date_asc', 'title_date_desc', 'stocked_asc' or 'stocked_desc'"
      # rubocop:enable LineLength

      def initialize(articles, sort_type = Consts::UPDATE_DATE_DESC)
        validate_articles(articles)
        validate_article(articles)
        validate_sort_type(sort_type)
        @articles = articles
        @sort_type = sort_type
      end

      def sort
        case @sort_type
        when Consts::CREATE_DATE_ASC then sort_asc(:created_at)
        when Consts::CREATE_DATE_DESC then sort_desc(:created_at)
        when Consts::UPDATE_DATE_ASC then sort_asc(:updated_at)
        when Consts::UPDATE_DATE_DESC then sort_desc(:updated_at)
        end
      end

      private

      def validate_articles(articles)
        return if articles.is_a?(Array)
        fail ArgumentError, format(ARTICLES_CLASS_ERROR, articles.class)
      end

      def validate_article(articles)
        return if articles.empty?
        articles.each do |article|
          next if article.is_a?(Article)
          fail ArgumentError, format(ARTICLE_CLASS_ERROR, article.class)
        end
      end

      def validate_sort_type(sort_type)
        return if Consts::ALL_TYPES.include?(sort_type)
        fail ArgumentError, format(SORT_TYPE_ERROR, sort_type)
      end

      def sort_asc(asc_key)
        @articles.sort_by! { |e|e.send(asc_key) }
      end

      def sort_desc(desc_key)
        @articles = @articles.sort_by { |e|e.send(desc_key) }.reverse
      end
    end
  end
end
