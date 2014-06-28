require 'date'

module QiitaMatome
  # QiitaMatome::Article
  class Article
    attr_accessor :user, :title, :uuid, :created_at, :updated_at, :tags, :stock_count # rubocop:disable LineLength

    def initialize(options = {})
      @user = options[:user]
      @title = options[:title]
      @uuid = options[:uuid]
      @created_at = DateTime.parse(options[:created_at]) unless options[:created_at].nil?
      @updated_at = DateTime.parse(options[:updated_at]) unless options[:created_at].nil?
      @tags = options[:tags]
      @stock_count = options[:stock_count]
      yield(self) if block_given?
    end
  end
end
