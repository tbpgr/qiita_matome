# encoding: utf-8
require 'spec_helper'
require 'models/article'
require 'display/display_consts'
require 'display/displayer'
require 'validators/display_columns_validator'

describe QiitaMatome::Validators::DisplayColumnsValidator do
  context :validate do
    cases = [
      {
        case_no: 1,
        case_title: 'valid display_columns',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: [:no, :title],
        expect_error: false
      },
      {
        case_no: 2,
        case_title: 'invalid display_columns "invalid"',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: 'invalid',
        expect_error: true
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing
          display_columns_list = Array(c[:display_columns])

          # -- when/then --
          if c[:expect_error]
            -> { QiitaMatome::Validators::DisplayColumnsValidator.validate(display_columns_list) }.should raise_error(ArgumentError)
          else
            -> { QiitaMatome::Validators::DisplayColumnsValidator.validate(display_columns_list) }.should_not raise_error
          end
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
end
