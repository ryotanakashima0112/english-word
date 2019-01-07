Rails.application.routes.draw do
  root to: 'homes#top'
  resources :vocabularies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "english", to: "vocabularies#english_to_japanies_mode"
  get "japanies", to: "vocabularies#japanies_to_english_mode"
end
