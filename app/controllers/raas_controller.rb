require "json"

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
  end

  # サンプル：レイアウト一覧の取得
  def load_layouts
    # @restClientのセットアップ
    prepare(params)

    # restClientを通してレイアウト一覧取得のAPIを実行
    response = @restClient.get("/report/layouts/#{params["application"]}/#{params["schema"]}", nil)

    # 結果をJSONで返す
    render json: response.body
  end

  # サンプル：CSVインポートにより作成されたログデータの取得
  def load_log_data
    # @restClientのセットアップ
    prepare(params)

    # restClientを通してログデータ取得のAPIを実行
    log_response = @restClient.get("/datatraveler/import/logs/#{params["targetId"]}", nil)
    data_import_log = JSON[log_response.body]

		if data_import_log["status"] = "FINISH"
			# ログデータ詳細取得APIを実行
      log_detail_response = @restClient.get("/datatraveler/import/logs/#{params["targetId"]}/data", nil)
			data_import_log["details"] = JSON[log_detail_response.body]
    end

    # 結果をJSONで返す
    render json: data_import_log
  end
end
