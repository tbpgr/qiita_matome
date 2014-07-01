# encoding: utf-8
require 'validators/articles_validator'
require 'validators/article_validator'
require 'validators/display_columns_validator'

module QiitaMatome
  #  QiitaMatome::Display
  module Display
    # QiitaMatome::Display::Displayer
    class Displayer
      attr_reader :title, :articles, :display_columns

      def initialize(title, articles,
          display_columns = [:no, :title, :created_at, :stock_count])
        Validators::ArticlesValidator.validate(articles)
        Validators::ArticleValidator.validate(articles)
        display_columns_list = Array(display_columns)
        Validators::DisplayColumnsValidator.validate(display_columns_list)
        symbolized_display_columns = display_columns_list.map(&:to_sym)
        @title = title
        @articles = articles
        @display_columns = symbolized_display_columns
      end

      def display_title
        "# #{@title}"
      end

      def table_header
        title_header = table_title_header
        title_align = table_align
        "#{title_header}\n#{title_align}\n"
      end

      def matome_updated
        "更新日: #{DateTime.now.strftime('%Y/%m/%d %H:%M:%S')}"
      end

      def display_article(no, article)
        disp = @display_columns.reduce([]) do |a, e|
          a << case e
               when :no then no
               when :title then article.title_link
               when :created_at then  article.created_at_ymdhms
               when :updated_at then  article.updated_at_ymdhms
               when :stock_count then article.stock_count
          end
        end
        "|#{disp.join('|')}|"
      end

      def display_articles
        display = []
        @articles.each.with_index(1) do |article, no|
          display << display_article(no, article)
        end
        display.join("\n") + "\n"
      end

      private

      def table_title_header
        header = @display_columns.reduce([]) do |a, e|
          a << Consts::COLUMNS_TITLE_MAP[e]
          a
        end
        "|#{header.join('|')}|"
      end

      def table_align
        align = @display_columns.reduce([]) do |a, e|
          a << case Consts::COLUMNS_ALIGN_MAP[e]
               when Consts::ALIGN_RIGHT then '--:'
               when Consts::ALIGN_LEFT then ':--'
               when Consts::ALIGN_CENTER then ':--:'
          end
          a
        end
        "|#{align.join('|')}|"
      end
    end
  end
end
