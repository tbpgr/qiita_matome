require 'date'

module QiitaMatome
  # QiitaMatome::Article
  class Article
    YMDHMS_DATETIME_FORMAT = '%Y/%m/%d %H:%M:%S'.freeze
    attr_accessor :user, :title, :uuid, :created_at, :updated_at, :tags, :stock_count # rubocop:disable LineLength

    def initialize(options = {})
      @user = options[:user]
      @title = options[:title]
      @uuid = options[:uuid]
      @created_at = DateTime.parse(options[:created_at]) unless options[:created_at].nil?
      @updated_at = DateTime.parse(options[:updated_at]) unless options[:updated_at].nil?
      @tags = options[:tags]
      @stock_count = options[:stock_count]
      yield(self) if block_given?
    end

    def created_at_ymdhms
      @created_at.strftime(YMDHMS_DATETIME_FORMAT)
    end

    def updated_at_ymdhms
      @updated_at.strftime(YMDHMS_DATETIME_FORMAT)
    end
  end
end
