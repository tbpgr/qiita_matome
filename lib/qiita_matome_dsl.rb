# encoding: utf-8
require 'qiita_matome_dsl_model'

module QiitaMatome
  class Dsl
    attr_accessor :qiita_matome

    # String Define
    [:user, :tag, :title, :output_file, :sort_type].each do |f|
      define_method f do |value|
        eval "@qiita_matome.#{f} = '#{value}'", binding
      end
    end

    # Array/Hash/Boolean Define
    [:display_columns, :excludes].each do |f|
      define_method f do |value|
        eval "@qiita_matome.#{f} = #{value}", binding
      end
    end

    def initialize
      @qiita_matome = QiitaMatome::DslModel.new
      @qiita_matome.output_file = 'matome.md'
      @qiita_matome.sort_type = 'create_date_desc'
      @qiita_matome.display_columns = [:no, :title, :create_date, :stocked]
      @qiita_matome.excludes = []
    end
  end
end
