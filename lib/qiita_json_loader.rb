require 'open-uri'
require 'openssl'
require 'json'

module QiitaMatome
  # QiitaMatome::QiitaJsonLoader
  class QiitaJsonLoader
    attr_reader :user, :articles
    def load(user)
      @user = user
      tmp_verbose = $VERBOSE
      $VERBOSE = nil
      OpenSSL::SSL.const_set('VERIFY_PEER', OpenSSL::SSL::VERIFY_NONE)
      $VERBOSE = tmp_verbose
      html = open("https://qiita.com/api/v1/users/#{user}/items").read
      articles = JSON.parser.new(html)
      @articles = articles.parse
    end
  end
end
