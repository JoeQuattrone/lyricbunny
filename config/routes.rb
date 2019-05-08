Rails.application.routes.draw do
  resources :artists, except: [:destroy]
  post '/update_likes', to: 'songs#update_likes'
  post '/update_likes_from_home', to: 'songs#update_likes_from_home'
  get '/trending_songs', to: 'songs#trending_songs'
  resources :songs, except: [:destroy]
end
