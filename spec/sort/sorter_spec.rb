# encoding: utf-8
require 'spec_helper'
require 'sort/sort_consts'
require 'sort/sorter'
require 'models/article'
require 'models/articles'

# rubocop:disable LineLength, UnusedMethodArgument
describe QiitaMatome::Sort::Sorter do
  context :new do
    cases = [
      {
        case_no: 1,
        case_title: 'valid args',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        sort_type: QiitaMatome::Sort::Consts::CREATED_AT_ASC
      },
      {
        case_no: 2,
        case_title: 'invalid articles class "String"',
        articles: 'String',
        sort_type: QiitaMatome::Sort::Consts::CREATED_AT_ASC,
        expect_error: true
      },
      {
        case_no: 3,
        case_title: 'invalid article class "String"',
        articles: [QiitaMatome::Article.new, 'String'],
        sort_type: QiitaMatome::Sort::Consts::CREATED_AT_ASC,
        expect_error: true
      },
      {
        case_no: 4,
        case_title: 'invalid sort_type "invalid"',
        articles: [QiitaMatome::Article.new, QiitaMatome::Article.new],
        sort_type: 'invalid',
        expect_error: true
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          if c[:expect_error]
            -> { QiitaMatome::Sort::Sorter.new(c[:articles], c[:sort_type]) }.should raise_error(ArgumentError)
            next
          end
          qss = QiitaMatome::Sort::Sorter.new(c[:articles], c[:sort_type])

          # -- when --
          actual_articles = qss.articles
          actual_sort_type = qss.sort_type

          # -- then --
          expect(actual_articles).to eq(c[:articles])
          expect(actual_sort_type).to eq(c[:sort_type])
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end

  context :sort do
    ARTICLES = [
      QiitaMatome::Article.new(
        user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
        title: 'title1',
        created_at: '2014-06-18 22:37:54 +0900',
        updated_at: '2014-06-26 02:25:11 +0900',
        tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
        likes_count: 2
      ),
      QiitaMatome::Article.new(
        user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
        title: 'title2',
        created_at: '2014-06-18 22:37:53 +0900',
        updated_at: '2014-06-26 02:25:09 +0900',
        tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
        likes_count: 3
      ),
      QiitaMatome::Article.new(
        user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
        title: 'title3',
        created_at: '2014-06-18 22:37:52 +0900',
        updated_at: '2014-06-26 02:25:10 +0900',
        tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
        likes_count: 10
      )
    ]
    cases = [
      {
        case_no: 1,
        case_title: 'create date asc',
        articles: ARTICLES,
        sort_type: QiitaMatome::Sort::Consts::CREATED_AT_ASC,
        expected: [
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title3',
            created_at: '2014-06-18 22:37:52 +0900',
            updated_at: '2014-06-26 02:25:10 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 10
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title2',
            created_at: '2014-06-18 22:37:53 +0900',
            updated_at: '2014-06-26 02:25:09 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 3
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title1',
            created_at: '2014-06-18 22:37:54 +0900',
            updated_at: '2014-06-26 02:25:11 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 2
          )
        ]
      },
      {
        case_no: 2,
        case_title: 'create date desc',
        articles: ARTICLES,
        sort_type: QiitaMatome::Sort::Consts::CREATED_AT_DESC,
        expected: [
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title1',
            created_at: '2014-06-18 22:37:54 +0900',
            updated_at: '2014-06-26 02:25:11 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 2
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title2',
            created_at: '2014-06-18 22:37:53 +0900',
            updated_at: '2014-06-26 02:25:09 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 3
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title3',
            created_at: '2014-06-18 22:37:52 +0900',
            updated_at: '2014-06-26 02:25:10 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 10
          )
        ]
      },
      {
        case_no: 3,
        case_title: 'update date asc',
        articles: ARTICLES,
        sort_type: QiitaMatome::Sort::Consts::UPDATED_AT_ASC,
        expected: [
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title2',
            created_at: '2014-06-18 22:37:53 +0900',
            updated_at: '2014-06-26 02:25:09 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 3
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title3',
            created_at: '2014-06-18 22:37:52 +0900',
            updated_at: '2014-06-26 02:25:10 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 10
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title1',
            created_at: '2014-06-18 22:37:54 +0900',
            updated_at: '2014-06-26 02:25:11 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 2
          )
        ]
      },
      {
        case_no: 4,
        case_title: 'update date desc',
        articles: ARTICLES,
        sort_type: QiitaMatome::Sort::Consts::UPDATED_AT_DESC,
        expected: [
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title1',
            created_at: '2014-06-18 22:37:54 +0900',
            updated_at: '2014-06-26 02:25:11 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 2
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title3',
            created_at: '2014-06-18 22:37:52 +0900',
            updated_at: '2014-06-26 02:25:10 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 10
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title2',
            created_at: '2014-06-18 22:37:53 +0900',
            updated_at: '2014-06-26 02:25:09 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 3
          )
        ]
      },
      {
        case_no: 5,
        case_title: 'title asc',
        articles: ARTICLES,
        sort_type: QiitaMatome::Sort::Consts::TITLE_ASC,
        expected: [
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title1',
            created_at: '2014-06-18 22:37:54 +0900',
            updated_at: '2014-06-26 02:25:11 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 2
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title2',
            created_at: '2014-06-18 22:37:53 +0900',
            updated_at: '2014-06-26 02:25:09 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 3
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title3',
            created_at: '2014-06-18 22:37:52 +0900',
            updated_at: '2014-06-26 02:25:10 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 10
          )
        ]
      },
      {
        case_no: 6,
        case_title: 'title desc',
        articles: ARTICLES,
        sort_type: QiitaMatome::Sort::Consts::TITLE_DESC,
        expected: [
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title3',
            created_at: '2014-06-18 22:37:52 +0900',
            updated_at: '2014-06-26 02:25:10 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 10
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title2',
            created_at: '2014-06-18 22:37:53 +0900',
            updated_at: '2014-06-26 02:25:09 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 3
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title1',
            created_at: '2014-06-18 22:37:54 +0900',
            updated_at: '2014-06-26 02:25:11 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 2
          )
        ]
      },
      {
        case_no: 7,
        case_title: 'likes_count asc',
        articles: ARTICLES,
        sort_type: QiitaMatome::Sort::Consts::LIKES_COUNT_ASC,
        expected: [
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title1',
            created_at: '2014-06-18 22:37:54 +0900',
            updated_at: '2014-06-26 02:25:11 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 2
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title2',
            created_at: '2014-06-18 22:37:53 +0900',
            updated_at: '2014-06-26 02:25:09 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 3
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title3',
            created_at: '2014-06-18 22:37:52 +0900',
            updated_at: '2014-06-26 02:25:10 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 10
          )
        ]
      },
      {
        case_no: 8,
        case_title: 'likes_count desc',
        articles: ARTICLES,
        sort_type: QiitaMatome::Sort::Consts::LIKES_COUNT_DESC,
        expected: [
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title3',
            created_at: '2014-06-18 22:37:52 +0900',
            updated_at: '2014-06-26 02:25:10 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 10
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title2',
            created_at: '2014-06-18 22:37:53 +0900',
            updated_at: '2014-06-26 02:25:09 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 3
          ),
          QiitaMatome::Article.new(
            user: { 'id' => 99_999, 'url_name' => 'tbpgr', 'profile_image_url' => '' },
            title: 'title1',
            created_at: '2014-06-18 22:37:54 +0900',
            updated_at: '2014-06-26 02:25:11 +0900',
            tags: [{ 'name' => 'Ruby', 'url_name' => 'ruby', 'icon_url' => '', 'versions' => [] }],
            likes_count: 2
          )
        ]
      }
    ]

    cases.each do |c|
      it "|case_no=#{c[:case_no]}|case_title=#{c[:case_title]}" do
        begin
          case_before c

          # -- given --
          qss = QiitaMatome::Sort::Sorter.new(c[:articles], c[:sort_type])

          # -- when --
          qss.sort
          actual_list = qss.articles

          # -- then --
          actual_list.each_with_index do |actual_article, i|
            expect(actual_article.title).to eq(c[:expected][i].title)
          end
        ensure
          case_after c
        end
      end

      def case_before(c)
        # implement each case before
      end

      def case_after(c)
        # implement each case after
      end
    end
  end
end
# rubocop:enable LineLength, UnusedMethodArgument
