Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   devise_for :users

   root 'homes#top'
   get 'home/about' => 'homes#about'
 #book用 
resources :books, only: [:create, :index, :show, :edit, :update, :destroy, :update] do
	resource :favorites, only: [:create, :destroy]
	resource :post_comments, only: [:create, :destroy]
end
#user用
resources :users, only: [:show, :edit, :update, :index]
#フォロー用
post 'follow/:id' => 'relationships#follow', as: 'follow'
#フォロー外す用
post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'

get 'users/:user_id/follower' => 'relationships#follower', as: 'user_follower'
get 'users/:user_id/followed' => 'relationships#followed', as: 'user_followed'
end
