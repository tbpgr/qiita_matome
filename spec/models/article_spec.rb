# encoding: utf-8
require 'spec_helper'
require 'models/articles'
require 'models/article'

describe QiitaMatome::Article do
  context :<< do
    cases = [
      {
        case_no: 1,
        case_title: '2 list case',
        created_at: '2014-06-18 22:37:52 +0900',
        updated_at: '2015-07-19 23:47:53 +0900',
        expected_created_at: '2014/06/18 22:37:52',
        expected_updated_at: '2015/07/19 23:47:53'
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qiita_matome_article = QiitaMatome::Article.new(created_at: c[:created_at], updated_at: c[:updated_at])

          # -- when --
          actual_created_at = qiita_matome_article.created_at_ymdhms
          actual_updated_at = qiita_matome_article.updated_at_ymdhms

          # -- then --
          expect(actual_created_at).to eq(c[:expected_created_at])
          expect(actual_updated_at).to eq(c[:expected_updated_at])
        ensure
          case_after c
        end
      end

      def case_before(_c)
        # implement each case before
      end

      def case_after(_c)
        # implement each case after
      end
    end
  end

  context :+ do
    cases = [
      {
        case_no: 1,
        case_title: 'init 0 append 2 list case',
        init: [],
        appends: QiitaMatome::Articles.new([QiitaMatome::Article.new, QiitaMatome::Article.new]),
        expected: 2
      },
      {
        case_no: 2,
        case_title: 'init 2 append 2 list case',
        init: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        appends: QiitaMatome::Articles.new([QiitaMatome::Article.new, QiitaMatome::Article.new]),
        expected: 4
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qiita_matome_articles = QiitaMatome::Articles.new(c[:init])

          # -- when --
          qiita_matome_articles += c[:appends]
          actual = qiita_matome_articles.size

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(_c)
        # implement each case before
      end

      def case_after(_c)
        # implement each case after
      end
    end
  end

  context :size do
    cases = [
      {
        case_no: 1,
        case_title: '2 list case',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        expected: 2,
      },
      {
        case_no: 2,
        case_title: 'empty list case',
        articles: [],
        expected: 0,
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qiita_matome_articles = QiitaMatome::Articles.new(c[:articles])

          # -- when --
          actual = qiita_matome_articles.size

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(_c)
        # implement each case before
      end

      def case_after(_c)
        # implement each case after
      end
    end
  end

  context :each do
    cases = [
      {
        case_no: 1,
        case_title: '2 list case',
        articles: [QiitaMatome::Article.new(user: 1), QiitaMatome::Article.new(user: 2)],
        expected: 3,
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qiita_matome_articles = QiitaMatome::Articles.new(c[:articles])

          # -- when --
          total = 0
          qiita_matome_articles.each { |e|total += e.user }

          # -- then --
          expect(total).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(_c)
        # implement each case before
      end

      def case_after(_c)
        # implement each case after
      end
    end
  end

  context :filter_by_tag do
    cases = [
      {
        case_no: 1,
        case_title: 'init 4 Ruby-tag 2 list case',
        init: [
          QiitaMatome::Article.new(tag: 'Ruby'),
          QiitaMatome::Article.new(tag: 'Java'),
          QiitaMatome::Article.new(tag: 'Ruby'),
          QiitaMatome::Article.new(tag: 'C'),
        ],
        filter_tag: 'Ruby',
        expected: 2
      },
      {
        case_no: 1,
        case_title: 'init 4 Swift-tag 0 list case',
        init: [
          QiitaMatome::Article.new(tag: 'Ruby'),
          QiitaMatome::Article.new(tag: 'Java'),
          QiitaMatome::Article.new(tag: 'Ruby'),
          QiitaMatome::Article.new(tag: 'C'),
        ],
        filter_tag: 'Swift',
        expected: 0
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qiita_matome_articles = QiitaMatome::Articles.new

          # -- when --
          actual = qiita_matome_articles.filter_by_tag(c[:filter_tag])

          # -- then --
          # TODO: implement assertion code
          # expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(_c)
        # implement each case before
      end

      def case_after(_c)
        # implement each case after
      end
    end
  end
end
