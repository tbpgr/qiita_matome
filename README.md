# QiitaMatome

[![Build Status](https://travis-ci.org/tbpgr/qiita_matome.png?branch=master)](https://travis-ci.org/tbpgr/qiita_matome)
[![Coverage Status](https://coveralls.io/repos/tbpgr/qiita_matome/badge.png)](https://coveralls.io/r/tbpgr/qiita_matome)
[![Code Climate](https://codeclimate.com/github/tbpgr/qiita_matome.png)](https://codeclimate.com/github/tbpgr/qiita_matome)

Qiitaのまとめページジェネレーター  

## 概要

Qiitaの特定ユーザー、特定タグのリンクを一覧化したまとめ記事を生成する。

## 前提
* 認証不要(認証不要APIである、`GET /api/v1/users/:url_name/items` のみを利用する)
* 任意のユーザーの任意の1つのタグに限定してまとめ記事を作成する

    ※基本的には自分のユーザーのまとめを作ることを想定しています

## 確認済み環境
* ruby 2.0.0p451 環境にて動作確認済み

## サブコマンド

|コマンド|ショートカット|内容|
|:--|:--|:--|
|init|i|設定ファイル（ *Qiitamatome* ）を出力|
|matome|m|まとめ記事の生成。実行するためには事前に *Qiitamatome* を生成、編集する必要がある|
|help|h|ヘルプの表示|
|version|v|バージョンの表示|

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

Rubyの内部DSLになっているので、Rubyのコードを利用することも可能です。  
例えば、出力ファイルの名前に現在時刻を埋め込んだり、など。  

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

# Set your matome sort type. you can choose created_at_asc/desc, updated_at_asc/desc, title_asc/desc, stock_count_asc/desc
# sort_type allow only String
# sort_type's default value => "created_at_desc"
sort_type "created_at_desc"

# Set your matome display columns. you can choose :title, :created_at, :updated_at, :stock_count and :no
# display_columns allow only Array
# display_columns's default value => [:no, :title, :created_at, :stock_count]
display_columns [:no, :title, :created_at, :stock_count]

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
|output_file|○|matome.md|出力パス|
|sort_type|×|created_at_desc|まとめ記事内のソート順。詳しくはソート種別参照|
|display_columns|×|[:no, :title, :created_at, :stock_count]|まとめ記事の表示項目指定。指定順に並ぶ。詳しくは表示項目参照|
|exclude|×|[id1, id2...]|除外記事ID（uuid）を配列で指定。例えば、まとめ記事自信を除外するために指定|

### ソート種別

|種別|内容|
|:--|:--|
|created_at_asc|初回投稿日昇順|
|created_at_desc|初回投稿日降順|
|updated_at_asc|更新日昇順|
|updated_at_desc|更新日降順|
|title_asc|記事タイトル昇順|
|title_desc|記事タイトル降順|
|stock_count_asc|ストック数昇順|
|stock_count_desc|ストック数降順。つまり人気記事順|

### 表示項目

|項目名|内容|
|:--|:--|
|:title|記事タイトル。該当記事へのリンクになる|
|:created_at|初回投稿日 「YYYY/MM/DD hh:mi:ss」 フォーマット|
|:updated_at|更新日 「YYYY/MM/DD hh:mi:ss」 フォーマット|
|:stock_count|ストック数|
|:no|連番|

## インストール

Add this line to your application's Gemfile:

    gem 'qiita_matome'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qiita_matome


## 使用手順の例

* 設定ファイル( *Qiitamatome* )の生成

~~~bash
$ qiitam init
~~~

または

~~~bash
$ qiitam i
~~~

* 設定ファイル( *Qiitamatome* )を編集

ユーザー *tbpgr* の *rubocop* タグの記事をまとめ記事として出力します。  

~~~bash
user            "tbpgr"
tag             "rubocop"
title           "RuboCop まとめ タイトル昇順"
output_file     "./matome_title_asc.md"
sort_type       "title_asc"
display_columns [:no, :title, :created_at, :stock_count]
# まとめ記事を除外
excludes        ['edbfecb6a6789dd54f47']
~~~

* まとめ記事作成を実行

~~~bash
$ qiitam matome
~~~

または

~~~bash
$ qiitam m
~~~

* 結果を確認

~~~bash
$ cat ./matome_title_asc.md
# 内容が表示される
~~~

## 出力サンプル

[matome_title_asc.md](./samples/matome_title_asc.md)

## History
* version 0.0.1 : 2014/07/03 : first release

## Contributing

1. Fork it ( https://github.com/tbpgr/qiita_matome/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## 補足
* この gem は [dslable gem](https://github.com/tbpgr/dslable) を利用して作成しています
* この gem のテストクラスは [rspec_piccolo gem](https://github.com/tbpgr/rspec_piccolo) を利用してひな形を生成しています
