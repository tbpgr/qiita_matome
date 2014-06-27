module QiitaMatome
  # QiitaMatome::Article
  class Article
    attr_accessor :user, :title, :uuid, :created_at, :updated_at, :tags, :stock_users # rubocop:disable LineLength

    def initialize(options = {})
      @user = options[:user]
      @title = options[:title]
      @uuid = options[:uuid]
      @created_at = options[:created_at]
      @updated_at = options[:updated_at]
      @tags = options[:tags]
      @stock_users = options[:stock_users]
      yield(self) if block_given?
    end
  end
end
