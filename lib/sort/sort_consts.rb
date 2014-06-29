# encoding: utf-8

module QiitaMatome
  #  QiitaMatome::Sort
  module Sort
    # QiitaMatome::Sort::Consts
    module Consts
      CREATE_DATE_ASC = 'create_date_asc'.freeze
      CREATE_DATE_DESC = 'create_date_desc'.freeze
      UPDATE_DATE_ASC = 'update_date_asc'.freeze
      UPDATE_DATE_DESC = 'update_date_desc'.freeze
      TITLE_ASC = 'title_asc'.freeze
      TITLE_DESC = 'title_desc'.freeze
      STOCKED_ASC = 'stocked_asc'.freeze
      STOCKED_DESC = 'stocked_desc'.freeze
      ALL_TYPES = [
        CREATE_DATE_ASC,
        CREATE_DATE_DESC,
        UPDATE_DATE_ASC,
        UPDATE_DATE_DESC,
        TITLE_ASC,
        TITLE_DESC,
        STOCKED_ASC,
        STOCKED_DESC
      ]
    end
  end
end
