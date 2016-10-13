Rails.application.routes.draw do

  resources :clans, { format: false, only: [ :index, :show, :new, :create, :edit, :update, :destroy ] } do
    get    'battles/new'   => 'battles#new_clan_battle'
    post   'battles'       => 'battles#create_clan_battle'
  end

  resources :battles, { format: false } do
    resources :villas, { only: [ :edit, :update ] } do
      resources :attacks, { only: [ :new, :create, :edit, :update, :destroy ] }
    end

    member do
      # GET /battles/:id/refresh
      get    'refresh'    # ※member do の外側で get を定義すると /battles/:battle_id/refresh となり、controller内で実装しづらくなる。
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
