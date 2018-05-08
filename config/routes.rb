Rails.application.routes.draw do

  resources :service_reminders
  resources :pdf_types
  resources :locations
  resources :reports
  resources :logs
  resources :detail_requests
  resources :equipment_pdfs
  mount EpiCas::Engine, at: "/"
  devise_for :accounts

  get 'finances/index'
  # get 'finances/show'

  resources :accounts do
    post :search, on: :collection
  end
  resources :audits
  resources :pdfs do
    get :show_pdf, on: :member
  end
  resources :equipment do
    get :show_image, on: :member
    post :search, on: :collection
  end
  resources :pdfs do
    post :search, on: :collection
  end
  resources :locations do
    post :search, on: :collection
  end

  match "/403", to: "errors#error_403", via: :all
  match "/404", to: "errors#error_404", via: :all
  match "/422", to: "errors#error_422", via: :all
  match "/500", to: "errors#error_500", via: :all

  get :ie_warning, to: 'errors#ie_warning'
  get :javascript_warning, to: 'errors#javascript_warning'

  root to: "pages#home"

  #get :splash, to: 'pages#splash'
  #get :borrowing, to: 'pages#borrowing'
  #get :returning, to: 'pages#returning'
  #get :home, to: "pages#home"
  get :view_items, to: 'equipment#index'
  get :new_equipment, to: 'equipment#new'
  # get :add_equipment, to: 'pages#add'
  # get :view_account_archive, to: 'pages#view_account_archive'
  # get :view_item_archive, to: 'pages#view_item_archive'
  # get :view_pdf, to: 'pages#view_pdf'
  # get :tables, to: 'pages#tables'
  # get :user, to: 'pages#user'
  # get :item, to: 'pages#item'
  # get :add_account, to: 'pages#add_account'
  # get :view_laboratories, to: 'pages#view_laboratories'
  # get :laboratory, to: 'pages#laboratory'
  get 'details/new/:id', to: 'details#new'
  get 'details/toggle_is_archived/:id', to: 'details#toggle_is_archived'
  get 'detail_requests/approve/:id', to: 'detail_requests#approve'
  get 'detail_requests/approve_equipment/:id', to: 'detail_requests#approve_equipment'
  get 'detail_requests/remove_equipment/:id', to: 'detail_requests#deny_equipment'
  get 'detail_requests/approve_extension/:id', to: 'detail_requests#approve_extension'
  get 'detail_requests/reject_extension/:id', to: 'detail_requests#reject_extension'
  get 'reports/new/:a_id', to: 'reports#new'
  get 'reports', to: 'reports#index'
  get 'audits/new/:s_id', to: 'audits#new'
  get 'trainings/add_equipment/:p_id/:t_id', to: 'trainings#add_equipment'
  get 'trainings/add_equipment/:p_id', to: 'trainings#add_equipment'
  get 'trainings/add_account/:a_id/:t_id', to: 'trainings#add_account'
  get 'trainings/add_account/:a_id', to: 'trainings#add_account'
  get 'trainings/remove_account/:id', to: 'trainings#remove_account'
  get 'trainings/remove_equipment/:id', to: 'trainings#remove_equipment'
  get 'pdfs/add_equipment/:e_id/:p_id', to: 'pdfs#add_equipment'
  get 'pdfs/add_equipment/:e_id', to: 'pdfs#add_equipment'
  get 'finances', to: 'finances#index'do
    post :search, on: :collection
  end
  resources :trainings
  resources :details
  get 'finances/:p_id', to: 'finances#index'
  get 'finances/:p_id/:s_id', to: 'finances#index'
  get :backup, to: 'backup#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
