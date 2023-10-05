Rails.application.routes.draw do
  root 'games#index'

  resource :games do
    get :index
    get :play
  end
end
