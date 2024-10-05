Rails.application.routes.draw do
  # RaasのcreateSession用のAPI
  post '/raas/datatraveler/session', to: 'raas#datatraveler_session'
  post '/raas/report/session', to: 'raas#report_session'

  # Raasのサンプルコードで使用するAPI
  get '/raas/report/layout/:application/:schema', to: 'raas#load_layouts'
  get '/raas/report/result/:targetId', to: 'raas#load_log_data'
end
