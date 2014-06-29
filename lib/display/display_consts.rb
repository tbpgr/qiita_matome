# encoding: utf-8

module QiitaMatome
  #  QiitaMatome::Display
  module Display
    # QiitaMatome::Display::Consts
    module Consts
      TITLE = :title.freeze
      CREATE_DATE = :create_date.freeze
      STOCKED = :stocked.freeze
      NO = :no.freeze

      ALIGN_RIGHT = :right
      ALIGN_LEFT = :left
      ALIGN_CENTER = :center

      COLUMNS = [TITLE, CREATE_DATE, STOCKED, NO]
      COLUMNS_ALIGN_MAP = {
        TITLE => ALIGN_LEFT,
        CREATE_DATE => ALIGN_CENTER,
        STOCKED => ALIGN_RIGHT,
        NO => ALIGN_RIGHT
      }
      COLUMNS_TITLE_MAP = {
        TITLE => 'タイトル',
        CREATE_DATE => '作成日',
        STOCKED => 'ストック数',
        NO => 'No.'
      }
    end
  end
end
