Rails.application.routes.draw do
  resources :artists, except: [:destroy]
  post '/update_likes', to: 'songs#update_likes'
  get '/trending_songs', to: 'songs#trending_songs'
  resources :songs, except: [:destroy]
end
