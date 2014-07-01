# encoding: utf-8
require 'spec_helper'
require 'models/article'
require 'sort/sort_consts'
require 'validators/sort_type_validator'

# rubocop:disable LineLength
describe QiitaMatome::Validators::SortTypeValidator do
  context :validate do
    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        sort_type: QiitaMatome::Sort::Consts::CREATED_AT_ASC,
        expect_error: false
      },
      {
        case_no: 4,
        case_title: 'invalid sort_type "invalid"',
        sort_type: 'invalid',
        expect_error: true
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          # nothing

          # -- when/then --
          if c[:expect_error]
            -> { QiitaMatome::Validators::SortTypeValidator.validate(c[:sort_type]) }.should raise_error(ArgumentError)
          else
            -> { QiitaMatome::Validators::SortTypeValidator.validate(c[:sort_type]) }.should_not raise_error
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
# rubocop:enable LineLength
