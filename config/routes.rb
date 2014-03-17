QuizzardApi::Application.routes.draw do
  resources :quizes, :only => [] do
    collection do
      post :start
      post :answer_correct
      post :next_question
      get :rank
    end
  end

  resources :questions
  resources :users, :only => [:create] do
    collection do
      post :join
    end
  end

  match '*path', :to => 'cors#options', :via => [:options]
end
