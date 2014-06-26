# encoding: utf-8
require 'active_model'

module QiitaMatome
  class DslModel
    include ActiveModel::Model

    # Set your qiita user name
    attr_accessor :user
    validates :user, presence: true

    # Set your matome target tag name
    attr_accessor :tag
    validates :tag, presence: true

    # Set your matome title
    attr_accessor :title
    validates :title, presence: true

    # Set your matome file's output path
    attr_accessor :output_file
    validates :output_file, presence: true

    # Set your matome sort type. you can choose create_date_asc/desc, update_date_asc/desc, title_asc/desc, stocked_asc/desc
    attr_accessor :sort_type

    # Set your matome display columns. you can choose :title, :create_date, :update_date, :stocked and :no
    attr_accessor :display_columns

    # Set your matome exclude files
    attr_accessor :excludes
  end
end
