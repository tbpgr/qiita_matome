# encoding: utf-8
require 'display/displayer'
require 'file_writer'
require 'models/article'
require 'models/articles'
require 'qiita_json_loader'
require 'qiita_matome_dsl'
require 'sort/sorter'

module QiitaMatome
  #  QiitaMatome Core
  class Core
    QIITA_MATOME_FILE = 'Qiitamatomefile'
    QIITA_MATOME_TEMPLATE = <<-EOS
# encoding: utf-8

# Set your qiita user name
# user is required
# user allow only String
user "your value"

# Set your matome target tag name
# tag is required
# tag allow only String
tag "your value"

# Set your matome title
# title is required
# title allow only String
title "your value"

# Set your matome file's output path
# output_file is required
# output_file allow only String
# output_file's default value => "matome.md"
output_file "matome.md"

# Set your matome sort type. you can choose created_at_asc/desc, updated_at_asc/desc, title_asc/desc, stock_count_asc/desc
# sort_type allow only String
# sort_type's default value => "created_at_desc"
sort_type "created_at_desc"

# Set your matome display columns. you can choose :title, :created_at, :updated_at, :stock_count and :no
# display_columns allow only Array
# display_columns's default value => [:no, :title, :created_at, :stock_count]
display_columns [:no, :title, :created_at, :stock_count]

# Set your matome exclude files
# excludes allow only Array
# excludes's default value => []
excludes []

    EOS

    # Generate Qiitamatomefile to current directory.
    def init
      File.open(QIITA_MATOME_FILE, 'w') { |f|f.puts QIITA_MATOME_TEMPLATE }
    end

    # Generate QiitaMatome markdown file.
    def matome
      dsl = read_dsl
      user = dsl.qiita_matome.user
      qjl = QiitaJsonLoader.new
      qjl.load(user)
      articles = qjl.articles
      tag = dsl.qiita_matome.tag
      filterd_articles = articles.filter_by_tag(tag)
      sort_type = dsl.qiita_matome.sort_type
      sorter = Sort::Sorter.new(filterd_articles, sort_type)
      sorted_articles = sorter.sort
      title = dsl.qiita_matome.title
      display_columns = dsl.qiita_matome.display_columns
      markdown = read_markdown(sorted_articles, title, display_columns)
      output_file = dsl.qiita_matome.output_file
      fw = QiitaMatome::FileWriter.new(output_file, markdown)
      fw.write
    end

    private

    def read_dsl
      src = File.open(QIITA_MATOME_FILE) { |f|f.read }
      dsl = QiitaMatome::Dsl.new
      dsl.instance_eval src
      dsl
    end

    def read_markdown(articles, title, display_columns)
      dd = Display::Displayer.new(title, articles, display_columns)
      display_title = dd.display_title
      table_header = dd.table_header
      display_articles = dd.display_articles
      <<-EOS
#{display_title}

#{table_header}#{display_articles}
      EOS
    end
  end
end
