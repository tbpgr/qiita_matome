# encoding: utf-8

module QiitaMatome
  #  QiitaMatome::Validators
  module Validators
    # ArticlesValidator
    class ArticlesValidator
      ARTICLES_CLASS_ERROR = "invalid argument class '%s'. articles must be Array" # rubocop:disable LineLength

      def self.validate(articles)
        return if articles.is_a?(Array)
        fail ArgumentError, format(ARTICLES_CLASS_ERROR, articles.class)
      end
    end
  end
end
