# encoding: utf-8
require 'spec_helper'
require 'sort/sort_consts'
require 'sort/sorter'
require 'models/article'
require 'models/articles'

describe QiitaMatome::Sort::Sorter do
  context :new do
    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        sort_type: QiitaMatome::Sort::Consts::CREATE_DATE_ASC
      },
      {
        case_no: 2,
        case_title: 'invalid articles class "String"',
        articles: 'String',
        sort_type: QiitaMatome::Sort::Consts::CREATE_DATE_ASC,
        expect_error: true
      },
      {
        case_no: 3,
        case_title: 'invalid article class "String"',
        articles: [QiitaMatome::Article.new, 'String'],
        sort_type: QiitaMatome::Sort::Consts::CREATE_DATE_ASC,
        expect_error: true
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          if c[:expect_error]
            -> { QiitaMatome::Sort::Sorter.new(c[:articles], c[:sort_type]) }.should raise_error(ArgumentError)
            next
          end
          qss = QiitaMatome::Sort::Sorter.new(c[:articles], c[:sort_type])

          # -- when --
          actual_articles = qss.articles
          actual_sort_type = qss.sort_type

          # -- then --
          expect(actual_articles).to eq(c[:articles])
          expect(actual_sort_type).to eq(c[:sort_type])
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
