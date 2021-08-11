# グミサーチ

新商品の移り変わりが激しいグミを食べ逃がさないために、グミの目撃情報を共有するためのサービスです。
レビューも投稿できるようになっており、お気に入りのグミの魅力をアピールできます。


### 作成した目的

TwitterなどのSNSで紹介されているグミが近くの店舗で見当たらず、ネット販売もされておらず、食べたくても食べられない事がありました。
本アプリはそういった悩みを解決するために、グミの登録、位置情報の共有ができる仕様を意識して作成しました。


### URL

https://gummy-search.herokuapp.com


### 使い方

#### トップ画面
![Image home#top](readme_image/home_top.png)


### 使用技術

* HTML/CSS
* Javascript
* Ruby 2.7.3
* Rails 6.1.4
* RSpec/Rubocop
* MySQL
* Docker/Docker-compose
* CircleCI(ci/cd)
* Heroku
* AWS S3
* Google Maps API


### 機能一覧

* ユーザー登録・編集/ログイン機能
* adminユーザー機能
* グミ登録機能
* グミ検索機能(フリーワード、メーカー、フレーバー)
* レビュー機能
* 目撃情報(位置情報)投稿機能
