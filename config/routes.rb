QuizzardApi::Application.routes.draw do
  resources :quizes, :only => [] do
    collection do
      post :start
    end
  end

  resources :questions
  resources :users, :only => [:create] do
    collection do
      get :join
    end
  end

  match '*path', :to => 'cors#options', :via => [:post, :get]
end
