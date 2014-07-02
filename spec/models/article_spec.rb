# encoding: utf-8
require 'spec_helper'
require 'models/article'

# rubocop:disable LineLength, UnusedMethodArgument
describe QiitaMatome::Article do
  context :created_at_ymdhms do
    cases = [
      {
        case_no: 1,
        case_title: '2 list case',
        init: {
          'created_at' => '2014-06-17 21:29:59 +0900',
          'updated_at' => '2014-06-18 20:28:58 +0900'
        },
        expected: '2014/06/17 21:29:59'
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          article = QiitaMatome::Article.new(c[:init])

          # -- when --
          actual = article.created_at_ymdhms

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

  context :updated_at_ymdhms do
    cases = [
      {
        case_no: 1,
        case_title: '2 list case',
        init: {
          'created_at' => '2014-06-17 21:29:59 +0900',
          'updated_at' => '2014-06-18 20:28:58 +0900'
        },
        expected: '2014/06/18 20:28:58'
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          article = QiitaMatome::Article.new(c[:init])

          # -- when --
          actual = article.updated_at_ymdhms

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

  context :title_link do
    cases = [
      {
        case_no: 1,
        case_title: '2 list case',
        init: {
          'title' => 'title | subtitle',
          'uuid' => '123',
          'user' => { 'url_name' => 'tbpgr' }
        },
        expected: '[title  subtitle](http://qiita.com/tbpgr/items/123)'
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          article = QiitaMatome::Article.new(c[:init])

          # -- when --
          actual = article.title_link

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
end
# rubocop:enable LineLength, UnusedMethodArgument
