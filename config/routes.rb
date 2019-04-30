Rails.application.routes.draw do
  resources :artists, except: [:destroy]
  resources :songs, except: [:destroy]
  patch '/artist:id/songs/:id/update_likes', to: 'songs#update_likes'
end
