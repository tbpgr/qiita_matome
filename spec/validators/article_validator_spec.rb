# encoding: utf-8
require 'spec_helper'
require 'models/article'
require 'validators/article_validator'

# rubocop:disable LineLength, UnusedMethodArgument
describe QiitaMatome::Validators::ArticleValidator do
  context :validate do
    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        expect_error: false
      },
      {
        case_no: 2,
        case_title: 'invalid article class "String"',
        articles: [QiitaMatome::Article.new, 'String'],
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
            -> { QiitaMatome::Validators::ArticleValidator.validate(c[:articles]) }.should raise_error(ArgumentError)
          else
            -> { QiitaMatome::Validators::ArticleValidator.validate(c[:articles]) }.should_not raise_error
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
# rubocop:enable LineLength, UnusedMethodArgument
