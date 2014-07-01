# encoding: utf-8

module QiitaMatome
  #  QiitaMatome::Validators
  module Validators
    # ArticleValidator
    class ArticleValidator
      ARTICLE_CLASS_ERROR = "invalid argument class '%s'.article must be Array"

      def self.validate(articles)
        return if articles.empty?
        articles.each do |article|
          next if article.is_a?(Article)
          fail ArgumentError, format(ARTICLE_CLASS_ERROR, article.class)
        end
      end
    end
  end
end
