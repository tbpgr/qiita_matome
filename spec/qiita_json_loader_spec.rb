# encoding: utf-8
require 'spec_helper'
require 'qiita_json_loader'
require 'json'
require 'open-uri'
require 'openssl'
require 'models/article'
require 'models/articles'

describe QiitaMatome::QiitaJsonLoader do
  context :load do
    cases = [
      {
        case_no: 1,
        case_title: 'valid case',
        user: 'user',
        expected: 200
      }
    ]

    # Dummy
    class Dummy
      def read
        <<-EOS
[
  {"uuid":"a655ad5e017d28f8982e"},
  {"uuid":"a655ad5e017d28f8982f"}
]
        EOS
      end
    end

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qiita_matome_qiita_json_loader = QiitaMatome::QiitaJsonLoader.new
          qiita_matome_qiita_json_loader.stub(:open).and_return(Dummy.new)

          # -- when --
          qiita_matome_qiita_json_loader.load(c[:user])
          actual = qiita_matome_qiita_json_loader.articles

          # -- then --
          expect(actual.articles.size).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c) # rubocop:disable UnusedMethodArgument
        # implement each case before
      end

      def case_after(c) # rubocop:disable UnusedMethodArgument
        # implement each case after
      end
    end
  end
end
