# encoding: utf-8
require 'sort/sort_consts'
require 'validators/article_validator'
require 'validators/articles_validator'

module QiitaMatome
  #  QiitaMatome::Sort
  module Sort
    # QiitaMatome::Sort::Sorter
    class Sorter
      attr_reader :articles, :sort_type
      # rubocop:disable LineLength
      SORT_TYPE_ERROR = "invalid sort_type '%s'. sort_type must be 'create_date_asc', 'create_date_desc', 'update_date_asc', 'update_date_desc', 'title_date_asc', 'title_date_desc', 'stocked_asc' or 'stocked_desc'"
      # rubocop:enable LineLength

      SORT_PATTERNS = {
        Consts::CREATE_DATE_ASC => { send_method: :sort_asc, sort_key: :created_at },
        Consts::CREATE_DATE_DESC => { send_method: :sort_desc, sort_key: :created_at },
        Consts::UPDATE_DATE_ASC => { send_method: :sort_asc, sort_key: :updated_at },
        Consts::UPDATE_DATE_DESC => { send_method: :sort_desc, sort_key: :updated_at },
        Consts::TITLE_ASC => { send_method: :sort_asc, sort_key: :title },
        Consts::TITLE_DESC => { send_method: :sort_desc, sort_key: :title },
        Consts::STOCKED_ASC => { send_method: :sort_asc, sort_key: :stock_count },
        Consts::STOCKED_DESC => { send_method: :sort_desc, sort_key: :stock_count }
      }

      def initialize(articles, sort_type = Consts::UPDATE_DATE_DESC)
        Validators::ArticlesValidator.validate(articles)
        Validators::ArticleValidator.validate(articles)
        validate_sort_type(sort_type)
        @articles = articles
        @sort_type = sort_type
      end

      def sort
        sort_pattern = SORT_PATTERNS[@sort_type]
        send(sort_pattern[:send_method], sort_pattern[:sort_key])
      end

      private

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
