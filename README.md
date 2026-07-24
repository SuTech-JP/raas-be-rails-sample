# raas-be-go-sample

Rails向けBackendソースのサンプルです

## 1.起動方法

### 1.1 依存ライブラリの取得
依存ライブラリの取得のため、以下のコマンドを実行します

`bundle install`

### 1.2 config/environments/development.rbを更新する
（SuTech社より取得した値をXXXX部分に記載）
```
Raas::Client::Rails::Engine.config.raas_client_rails.landscape   = 'dev'
Raas::Client::Rails::Engine.config.raas_client_rails.application = 'XXXX'
Raas::Client::Rails::Engine.config.raas_client_rails.token = 'XXXX'
```

### 1.3 実行

`bin/rails server`

## 2.サンプル概要
本サンプルは別途SuTech社が提供するFrontend用サンプルと結合して動作する想定のサンプルとなっています。
本サンプルでは以下３つのAPIを提供しています。

### 2.1 Frontend用コンポーネントを表示するためのsession作成用API
- /raas/report/session
- /raas/datatraveler/session

### 2.2 帳票作成結果（PDF/JSON/CSV）を取得する
- /raas/report/result/{targetId}

### 2.3 帳票レイアウト一覧を取得する
- /raas/report/layout/{application}/{schema}


## 3.組み込み方法

以下の手順に従って、組み込みを行ってください。

### 3.1 Raas提供のSDKライブラリを取得する

```ruby
gem "raas-client-rails"
```

```bash
$ bundle install
```

### 3.2 raas_controller.rbを実装する

```ruby
class RaasController < ApplicationController
  include Raas::Client::Rails::RaasControllerModule

  # 必須：テナントID、ユーザーIDをRaasに渡す
  def prepare_tenant_and_sub
      super
      # 現在のセッションのテナントIDをセットする
      @tenant = "sample_tenant_id"
      # 現在のセッションのユーザーIDをセットする
      @sub = "sample_user_id"
      # 現在のセッションのサブドメインをセットする(セッションごとにサブドメインが異なる場合)
      # @sub_domain = "sample_sub_domain"
      # 現在のユーザーに許可するスコープをセットする(スコープによる権限管理を使う場合、空白区切り)
      # @scope = "csv_admin.invoice pdf.invoice"
  end
end
```

### 3.3 `config/routes.rb` にエンドポイントを追加する

```ruby
  post '/raas/datatraveler/session', to: 'raas#datatraveler_session'
  post '/raas/report/session', to: 'raas#report_session'
```
