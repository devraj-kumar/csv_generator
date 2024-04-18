Rails.application.routes.draw do
  root 'homepage#index'

  resources :users, only: :index do
    get 'download_report', on: :member
    get 'download_report_status', on: :collection
  end

  resources :file_records, only: :show
end
