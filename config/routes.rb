Rails.application.routes.draw do
  resources :artists, except: [:destroy]
  post '/update_likes', to: 'songs#update_likes'
  resources :songs, except: [:destroy]
end
