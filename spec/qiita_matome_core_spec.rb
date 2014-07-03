# encoding: utf-8
require 'spec_helper'
require 'qiita_matome_core'
require 'qiita_json_loader'
require 'models/article'
require 'models/articles'
require 'timecop'

# rubocop:disable LineLength, UnusedMethodArgument, UselessAssignment
describe QiitaMatome::Core do
  context :init do
    cases = [
      {
        case_no: 1,
        case_title: 'output template',
        expected: QiitaMatome::Core::QIITA_MATOME_TEMPLATE
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          core = QiitaMatome::Core.new

          # -- when --
          core.init

          # -- then --
          actual = File.open(QiitaMatome::Core::QIITA_MATOME_FILE) { |f|f.read }
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        return unless File.exist? QiitaMatome::Core::QIITA_MATOME_FILE
        File.delete(QiitaMatome::Core::QIITA_MATOME_FILE)
      end
    end
  end

  context :matome do
    TMP_DIR = 'tmp'
    TEMPLATE = <<-EOS
# encoding: utf-8
user "tbpgr"
tag "Ruby"
title "some title"
output_file "output.md"
sort_type "created_at_desc"
display_columns [:no, :title, :created_at, :stock_count]
excludes []
    EOS

    MOCK_ARTICLES = QiitaMatome::Articles.new([
      QiitaMatome::Article.new(
      'user' => { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
      'title' => 'title1',
      'created_at' => '2014-06-18 22:37:54 +0900',
      'updated_at' => '2014-06-26 02:25:11 +0900',
      'tags' => [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
      'stock_count' => 1
      ),
      QiitaMatome::Article.new(
      'user' => { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
      'title' => 'title2',
      'created_at' => '2014-06-18 22:37:54 +0900',
      'updated_at' => '2014-06-26 02:25:11 +0900',
      'tags' => [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
      'stock_count' => 2
      ),
      QiitaMatome::Article.new(
      'user' => { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
      'title' => 'title3',
      'created_at' => '2014-06-18 22:37:54 +0900',
      'updated_at' => '2014-06-26 02:25:11 +0900',
      'tags' => [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
      'stock_count' => 3
      )
    ])

    cases = [
      {
        case_no: 1,
        case_title: 'valid case',
        define_src: TEMPLATE,
        output: 'output.md',
        expected: <<-EOS
# some title

更新日: 2014/04/01 00:00:00

|No.|タイトル|作成日|ストック数|
|--:|:--|:--:|--:|
|1|[title3](http://qiita.com/tbpgr/items/)|2014/06/18 22:37:54|3|
|2|[title2](http://qiita.com/tbpgr/items/)|2014/06/18 22:37:54|2|
|3|[title1](http://qiita.com/tbpgr/items/)|2014/06/18 22:37:54|1|

        EOS
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qiita_matome_core = QiitaMatome::Core.new
          QiitaMatome::QiitaJsonLoader.any_instance.stub(:load).and_return(nil)
          QiitaMatome::QiitaJsonLoader.any_instance.stub(:articles).and_return(MOCK_ARTICLES)
          Timecop.freeze(Time.local(2014, 4, 1))

          # -- when --
          qiita_matome_core.matome
          actual = File.open(c[:output], 'r:UTF-8') { |f|f.read }

          # -- then --
          expect(actual).to eq(c[:expected])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
        Dir.mkdir(TMP_DIR) unless Dir.exist? TMP_DIR
        Dir.chdir(TMP_DIR)
        File.open(QiitaMatome::Core::QIITA_MATOME_FILE, 'w') { |f|f.puts c[:define_src] }
      end

      def case_after(c)
        # implement each case after
        Dir.chdir('../')
        FileUtils.rm_rf(TMP_DIR) if Dir.exist? TMP_DIR
      end
    end
  end
end
# rubocop:enable LineLength, UnusedMethodArgument, UselessAssignment
