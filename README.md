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

## 3.組込方法
### 3.1 Gemfileに以下を追記し、Raasが提供するライブラリを取得する
`gem "raas-client-rails"`

### 3.2 FE用のsession関数を作成する
サンプル実装を参考に、2.1のsession作成用APIと同等の処理を作成する

### 3.3 データ連携処理を作成する（DataImportLogIdを保存する）
CSVインポートを実行した後にDataImportLogIdを保存する
（tenant , sub も一緒に保存することを推奨する）

### 3.4 データ連携処理を作成する（PDF作成処理が終わったDataImportLogIdの結果を取得する）
3.3のデータを元にBEにてデータ連携処理を実装する
データ連携処理は、別途SuTech社から提供されるシーケンス図を参考に実装する
