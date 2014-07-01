# QiitaMatome

Qiitaのまとめページジェネレーター  
※現在作成途中。完成したら RubyGemsに登録します

## 概要

Qiitaの特定ユーザー、特定タグのリンクを一覧化したまとめ記事を生成する。

## 前提
* 認証不要(認証不要APIである、`GET /api/v1/users/:url_name/items` のみを利用する)
* 任意のユーザーの任意の1つのタグに限定してまとめ記事を作成する

    ※基本的には自分のユーザーのまとめを作ることを想定しています

## 設定ファイルについて

RubyのDSLで作成されています。  
ファイル名は *Qiitamatome*  

~~~ruby
qiitam init
~~~

もしくは

~~~ruby
qiitam i
~~~

でテンプレートを生成できます。  
Gemfileのような感覚でご利用ください。  

### 設定ファイル自動生成時の内容

~~~ruby
# encoding: utf-8

# Set your qiita user name
# user is required
# user allow only String
user "your value"

# Set your matome target tag name
# tag is required
# tag allow only String
tag "your value"

# Set your matome title
# title is required
# title allow only String
title "your value"

# Set your matome file's output path
# output_file is required
# output_file allow only String
# output_file's default value => "matome.md"
output_file "matome.md"

# Set your matome sort type. you can choose created_at_asc/desc, updated_at_asc/desc, title_asc/desc, stocked_asc/desc
# sort_type allow only String
# sort_type's default value => "created_at_desc"
sort_type "created_at_desc"

# Set your matome display columns. you can choose :title, :created_at, :updated_at, :stocked and :no
# display_columns allow only Array
# display_columns's default value => [:no, :title, :created_at, :stocked]
display_columns [:no, :title, :created_at, :stocked]

# Set your matome exclude files
# excludes allow only Array
# excludes's default value => []
excludes []
~~~

### 設定項目一覧

|設定キー|必須|デフォルト|内容|
|:--|:--|:--|:--|
|user|○|なし|対象ユーザー|
|tag|○|なし|対象タグ|
|title|○|なし|まとめ記事タイトル|
|output_file|×|matome.md|出力パス|
|sort_type|×|created_at_desc|まとめ記事内のソート順。詳しくはソート種別参照|
|display_columns|×|[:no, :title, :created_at, :stocked]|まとめ記事の表示項目指定。指定順に並ぶ。詳しくは表示項目参照|
|exclude|×|[id1, id2...]|除外記事IDを配列で指定。例えば、まとめ記事自信を除外するために指定|

### ソート種別

|種別|内容|
|:--|:--|
|created_at_asc|初回投稿日昇順|
|created_at_desc|初回投稿日降順|
|updated_at_asc|更新日昇順|
|updated_at_desc|更新日降順|
|title_asc|記事タイトル昇順|
|title_desc|記事タイトル降順|
|stocked_asc|ストック数昇順|
|stocked_desc|ストック数降順。つまり人気記事順|

### 表示項目

|項目名|内容|
|:--|:--|
|:title|記事タイトル。該当記事へのリンクになる|
|:created_at|初回投稿日|
|:updated_at|更新日|
|:stocked|ストック数|
|:no|連番|

## インストール

Add this line to your application's Gemfile:

    gem 'qiita_matome'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qiita_matome


## 使用手順

* 設定ファイル( *Qiitamatome* )の生成

~~~bash
$ qiitam i
~~~

* 設定ファイル( *Qiitamatome* )を編集

~~~bash
user 'tbpgr'
tag 'rubocop'
title 'RuboCop まとめ'
output_file './rubocop_matome/rubocop_matome_20140607.md'
sort_type :stocked_desc
display_columns [:no, :title, :created_at, :stocked]
~~~

* まとめ記事作成を実行

~~~bash
$ qiitam g
~~~

* 結果を確認

~~~bash
$ cat ./rubocop_matome/rubocop_matome_20140626_235567.md'
# 内容が表示される
~~~

## 出力サンプル

※実装完了時に挿入※

## History
* version 0.0.1 : develop now

## Contributing

1. Fork it ( https://github.com/tbpgr/qiita_matome/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

