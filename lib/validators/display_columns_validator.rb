# encoding: utf-8
require 'display/display_consts'

module QiitaMatome
  #  QiitaMatome::Validators
  module Validators
    class DisplayColumnsValidator
      # rubocop:disable LineLength
      DISPLAY_COLUMNS_TO_SYM_ERROR = "Invalid display_columns. Display_columns's class must be implement 'to_sym' method."
      DISPLAY_COLUMNS_ERROR = "Invalid display_columns '%s'. Display_columns must be :title, :created_at, :updated_at, :stock_count or :no"
      # rubocop:enable LineLength

      def self.validate(display_columns)
        display_columns.each do |display_column|
          unless display_column.respond_to?(:to_sym)
            fail ArgumentError, DISPLAY_COLUMNS_TO_SYM_ERROR
          end
          display_column_sym = display_column.to_sym
          unless Display::Consts::COLUMNS.include?(display_column_sym)
            fail ArgumentError, format(DISPLAY_COLUMNS_ERROR, display_column_sym)
          end
        end
      end
    end
  end
end
