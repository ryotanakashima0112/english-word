Rails.application.routes.draw do
  root to: 'homes#top'
  resources :vocabularies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "english", to: "vocabularies#english_to_japanies_mode"
  post "mistake_english", to: "vocabularies#mistake_english"
  post "mistake_japanies", to: "vocabularies#mistake_japanies"
  get "japanies", to: "vocabularies#japanies_to_english_mode"
  get "search_english", to: "searches#search_english"
  get "search_japanies", to: "searches#search_japanies"
  get "english_word_test", to: "vocabularies#english_word_test"
  get "japanies_meaning_test", to: "vocabularies#japanies_meaning_test"
end
