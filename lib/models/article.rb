require 'date'

module QiitaMatome
  # QiitaMatome::Article
  class Article
    YMDHMS_DATETIME_FORMAT = '%Y/%m/%d %H:%M:%S'.freeze
    attr_accessor :user, :title, :uuid, :created_at, :updated_at, :tags, :likes_count # rubocop:disable LineLength

    # rubocop:disable MethodLength
    def initialize(options = {})
      @uuid = options['id']
      @user = options['user']
      @title = options['title']
      c_at = options['created_at']
      u_at = options['updated_at']
      @created_at = DateTime.parse(c_at) unless c_at.nil?
      @updated_at = DateTime.parse(u_at) unless u_at.nil?
      @tags = options['tags']
      @likes_count = options['likes_count']
      yield(self) if block_given?
    end
    # rubocop:enable MethodLength

    def created_at_ymdhms
      @created_at.strftime(YMDHMS_DATETIME_FORMAT)
    end

    def updated_at_ymdhms
      @updated_at.strftime(YMDHMS_DATETIME_FORMAT)
    end

    def title_link
      url_name = user['id']
      "[#{title.gsub('|', '')}](http://qiita.com/#{url_name}/items/#{uuid})"
    end
  end
end
