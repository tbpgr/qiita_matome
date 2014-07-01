# encoding: utf-8

module QiitaMatome
  #  QiitaMatome::Sort
  module Sort
    # QiitaMatome::Sort::Consts
    module Consts
      CREATED_AT_ASC = 'created_at_asc'.freeze
      CREATED_AT_DESC = 'created_at_desc'.freeze
      UPDATED_AT_ASC = 'updated_at_asc'.freeze
      UPDATED_AT_DESC = 'updated_at_desc'.freeze
      TITLE_ASC = 'title_asc'.freeze
      TITLE_DESC = 'title_desc'.freeze
      STOCK_COUNT_ASC = 'stock_count_asc'.freeze
      STOCK_COUNT_DESC = 'stock_count_desc'.freeze
      ALL_TYPES = [
        CREATED_AT_ASC,
        CREATED_AT_DESC,
        UPDATED_AT_ASC,
        UPDATED_AT_DESC,
        TITLE_ASC,
        TITLE_DESC,
        STOCK_COUNT_ASC,
        STOCK_COUNT_DESC
      ]
    end
  end
end
