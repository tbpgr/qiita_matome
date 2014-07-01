# encoding: utf-8
require 'sort/sort_consts'

module QiitaMatome
  #  QiitaMatome::Validators
  module Validators
    # SortTypeValidator
    class SortTypeValidator
      # rubocop:disable LineLength
      SORT_TYPE_ERROR = "invalid sort_type '%s'. sort_type must be 'created_at_asc', 'created_at_desc', 'updated_at_asc', 'updated_at_desc', 'title_date_asc', 'title_date_desc', 'stock_count_asc' or 'stock_count_desc'"
      # rubocop:enable LineLength

      def self.validate(sort_type)
        return if Sort::Consts::ALL_TYPES.include?(sort_type)
        fail ArgumentError, format(SORT_TYPE_ERROR, sort_type)
      end
    end
  end
end
