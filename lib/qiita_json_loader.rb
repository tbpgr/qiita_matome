require 'open-uri'
require 'openssl'
require 'json'
require 'models/article'
require 'models/articles'

module QiitaMatome
  # QiitaMatome::QiitaJsonLoader
  class QiitaJsonLoader
    attr_reader :user, :articles
    QIITA_URL = 'https://qiita.com/api/v2/users/%s/items?page=%s&per_page=%s'
    PER_PAGE = 25
    PAGE_LIMIT = 100

    def initialize
      @articles = Articles.new
    end

    def load(user)
      @user = user
      tmp_verbose = $VERBOSE
      $VERBOSE = nil
      OpenSSL::SSL.const_set('VERIFY_PEER', OpenSSL::SSL::VERIFY_NONE)
      $VERBOSE = tmp_verbose
      (1..PAGE_LIMIT).each do |page|
        before_size = @articles.size
        load_page(user, page)
        break if before_size == @articles.size
      end
    end

    private

    def load_page(user, page)
      json = open(format(QIITA_URL, user, page, PER_PAGE)).read
      json_articles = JSON.parser.new(json).parse
      @articles += json_articles.each_with_object(Articles.new) do |item, memo|
        memo << Article.new(item)
        memo
      end
    end
  end
end
