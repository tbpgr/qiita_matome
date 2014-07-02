# encoding: utf-8
require 'display/display_consts'

module QiitaMatome
  #  QiitaMatome::Validators
  module Validators
    # DisplayColumnsValidator
    class DisplayColumnsValidator
      # rubocop:disable LineLength
      DISPLAY_COLUMNS_TO_SYM_ERROR = "Invalid display_columns. Display_columns's class must be implement 'to_sym' method."
      DISPLAY_COLUMNS_ERROR = "Invalid display_columns '%s'. Display_columns must be :title, :created_at, :updated_at, :stock_count or :no"
      # rubocop:enable LineLength
      DCC = Display::Consts::COLUMNS

      class << self
        def validate(display_columns)
          display_columns.each do |display_column|
            validate_each(display_column)
          end
        end

        private

        def validate_each(display_column)
          validate_to_sym(display_column)
          validate_display_column(display_column.to_sym)
        end

        def validate_to_sym(display_column)
          return if display_column.respond_to?(:to_sym)
          fail ArgumentError, DISPLAY_COLUMNS_TO_SYM_ERROR
        end

        def validate_display_column(display_column)
          return if DCC.include?(display_column)
          fail ArgumentError, format(DISPLAY_COLUMNS_ERROR, display_column)
        end
      end
    end
  end
end
