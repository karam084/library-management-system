Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'books#index'
  # Defines the articles resource routes
  # resources :articles
  resources :books
  resources :libraries
  resources :students
  resources :book_students
  

end
