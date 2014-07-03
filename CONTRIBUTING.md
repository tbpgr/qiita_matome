# contributing 注意事項

## ブランチに関して
* *master* を直接編集せずにトピックブランチを作成して *pull request* を行うこと
* トピックブランチは修正内容を表した、わかりやすい名前にすること

## コーディング規約について

* **Ruby Style Guide** に準じます

    * [Ruby Style Guide 英語版](https://github.com/bbatsov/ruby-style-guide)
    * [Ruby Style Guide 和訳版](https://github.com/fortissimo1997/ruby-style-guide/blob/japanese/README.ja.md)

## RuboCopの利用に関して
* *rubocop* の警告が1件も発生しない状態で *pull request* を行うこと

~~~bash
# プロジェクトルートへ移動
$ cd qiita_matome
# プロジェクト全体に対して rubocop のチェックを実行
$ rubocop
Inspecting 32 file
.

32 file inspected, no offenses detected

# ※ no offenses detected になっていること
~~~

* *rubocop* の警告について、どうしても規約を守ることが難しい場合は警告除外用のコメントを利用してください

    除外方法については [こちらの記事](http://qiita.com/tbpgr/items/a9000c5c6fa92a46c206) を参照

## RSpecのテストに関して
* RSpecの単体テストを一緒に作成してください。
* 事情があって **例外的に** 単体テストの作成をしない場合は、手動テストの項目・手順を *manual_test_docs* に作成してください。

    ※なぜ単体テストを作成しないのか、 **理由** を *pull request* 時のコメントに記述してください。  

* テストの作成は [*rspec_piccolo gem*](https://github.com/tbpgr/rspec_piccolo) を利用していただけると体裁が整って嬉しいですが必須ではありません。

    ※冗長なテストよりは **DRYなテストが好みです**