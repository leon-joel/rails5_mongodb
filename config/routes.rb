Rails.application.routes.draw do

  resources :battles, { format: false } do
    resources :villas, { only: [ :edit, :update ] } do
      resources :attacks, { only: [ :new, :create, :edit, :update, :destroy ] }
    end
  end



  resources :plans
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
