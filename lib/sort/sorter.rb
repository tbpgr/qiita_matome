# encoding: utf-8
require 'sort/sort_consts'
require 'validators/article_validator'
require 'validators/articles_validator'
require 'validators/sort_type_validator'

module QiitaMatome
  #  QiitaMatome::Sort
  module Sort
    # QiitaMatome::Sort::Sorter
    class Sorter
      attr_reader :articles, :sort_type

      # rubocop:disable LineLength
      SORT_PATTERNS = {
        Consts::CREATED_AT_ASC => { send_method: :sort_asc, sort_key: :created_at },
        Consts::CREATED_AT_DESC => { send_method: :sort_desc, sort_key: :created_at },
        Consts::UPDATED_AT_ASC => { send_method: :sort_asc, sort_key: :updated_at },
        Consts::UPDATED_AT_DESC => { send_method: :sort_desc, sort_key: :updated_at },
        Consts::TITLE_ASC => { send_method: :sort_asc, sort_key: :title },
        Consts::TITLE_DESC => { send_method: :sort_desc, sort_key: :title },
        Consts::LIKES_COUNT_ASC => { send_method: :sort_asc, sort_key: :likes_count },
        Consts::LIKES_COUNT_DESC => { send_method: :sort_desc, sort_key: :likes_count },
      }
      # rubocop:enable LineLength

      def initialize(articles, sort_type = Consts::UPDATED_AT_DESC)
        Validators::ArticlesValidator.validate(articles)
        Validators::ArticleValidator.validate(articles)
        Validators::SortTypeValidator.validate(sort_type)
        @articles = articles
        @sort_type = sort_type
      end

      def sort
        sort_pattern = SORT_PATTERNS[@sort_type]
        send(sort_pattern[:send_method], sort_pattern[:sort_key])
      end

      private

      def sort_asc(asc_key)
        @articles.sort_by! { |e|e.send(asc_key) }
      end

      def sort_desc(desc_key)
        @articles = @articles.sort_by { |e|e.send(desc_key) }.reverse
      end
    end
  end
end
