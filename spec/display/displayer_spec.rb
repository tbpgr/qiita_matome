# encoding: utf-8
require 'spec_helper'
require 'display/display_consts'
require 'display/displayer'
require 'models/article'
require 'models/articles'

describe QiitaMatome::Display::Displayer do
  context :new do
    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: [:no, :title],
        expected_display_columns: [:no, :title]
      },
      {
        case_no: 2,
        case_title: 'invalid articles class "String"',
        articles: 'String',
        display_columns: [:no, :title],
        expect_error: true
      },
      {
        case_no: 3,
        case_title: 'invalid article class "String"',
        articles: [QiitaMatome::Article.new, 'String'],
        display_columns: [:no, :title],
        expect_error: true
      },
      {
        case_no: 4,
        case_title: 'invalid display_columns "invalid"',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: 'invalid',
        expect_error: true
      },
      {
        case_no: 5,
        case_title: 'valid args(auto convert display_columns)',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        display_columns: 'title',
        expected_display_columns: [:title]
      },
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          if c[:expect_error]
            -> { QiitaMatome::Display::Displayer.new('title', c[:articles], c[:display_columns]) }.should raise_error(ArgumentError)
            next
          end
          qdd = QiitaMatome::Display::Displayer.new('title', c[:articles], c[:display_columns])

          # -- when --
          actual_articles = qdd.articles
          actual_display_columns = qdd.display_columns

          # -- then --
          expect(actual_articles).to eq(c[:articles])
          expect(actual_display_columns).to eq(c[:expected_display_columns])
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
