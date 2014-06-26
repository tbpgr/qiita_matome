# encoding: utf-8
require 'qiita_matome_dsl'

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

# Set your matome sort type. you can choose create_date_asc/desc, update_date_asc/desc, title_asc/desc, stocked_asc/desc
# sort_type allow only String
# sort_type's default value => "create_date_desc"
sort_type "create_date_desc"

# Set your matome display columns. you can choose :title, :create_date, :update_date, :stocked and :no
# display_columns allow only Array
# display_columns's default value => [:no, :title, :create_date, :stocked]
display_columns [:no, :title, :create_date, :stocked]

# Set your matome exclude files
# excludes allow only Array
# excludes's default value => []
excludes []

    EOS

    # == generate Qiitamatomefile to current directory.
    def init
      File.open(QIITA_MATOME_FILE, 'w') { |f|f.puts QIITA_MATOME_TEMPLATE }
    end

    # == TODO: write your gem's specific contents
    def execute
      src = read_dsl
      dsl = QiitaMatome::Dsl.new
      dsl.instance_eval src

      # TODO: implement your gem's specific logic
    end

    private
    def read_dsl
      File.open(QIITA_MATOME_FILE) { |f|f.read }
    end
  end
end
