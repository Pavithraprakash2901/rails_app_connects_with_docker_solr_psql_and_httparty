Rails.application.routes.draw do
  
  get 'pages/user_detail'
  get 'pages/secon_form'
  get 'pages/third_form'
# resources :pages 

get 'pages', to: 'pages#home'

  # routes.rb
  #  resources :form1, only: [:new, :create]
  #  resources :form2, only: [:new, :create]
  #  resources :form3, only: [:new, :create]


get '/user_detail', to: 'pages#user_detail'
post '/user_detail', to: 'pages#create_user_detail'
get '/second_form', to: 'pages#second_form'
post '/second_form', to: 'pages#create_second_form'
get '/third_form', to: 'pages#third_form'
post '/third_form', to: 'pages#create_third_form'
get '/thankyou', to: 'pages#thankyou', as: 'thankyou'


# get 'search_bar', to: 'pages#search_bar', as: :search_bar

get 'search', to: 'search#search'


# devise_for :users

  get 'pages/home'
  devise_for :users
  root to: "pages#home"
  resources :users, only: [:home]
  devise_scope :user do  
  get '/users/sign_out' => 'devise/sessions#destroy' 
  


  # get '/first_form', to: 'pages#first_form'
  # post '/first_form', to: 'pages#create_first_form'

  # resources :first_forms, only: [:first_forms, :create_first_form]
  # resources :second_forms, only: [:second_form, :create_second_form]

  end  

  
  
end
