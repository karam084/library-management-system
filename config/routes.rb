Rails.application.routes.draw do
  devise_for :admins , controllers: { sessions: 'admins/sessions' , registrations: 'admins/registrations'}
  devise_for :librarians, controllers: { sessions: 'librarians/sessions' , registrations: 'librarians/registrations'}
  devise_for :students, controllers: { sessions: 'students/sessions' , registrations: 'students/registrations'}
  resources :transactions
  resources :librarians
  resources :libraries
  resources :admins
  resources :books
  resources :students
  resources :home_pages

  root  'home_page#index'

  get '/search' => 'books#search', :as => 'search'
  get '/checkout' => 'books#checkout', :as => 'checkout'
  get '/returnBook' => 'books#returnBook', :as => 'returnBook'
  get '/repealRequest' => 'books#repealRequest', :as => 'repealRequest'
  get '/bookmark' => 'books#bookmark', :as => 'bookmark'
  get '/unbookmark' => 'books#unbookmark', :as => 'unbookmark'
  get '/requestBook' => 'books#requestBook', :as => 'requestBook'
  get '/student_libraries_index' => 'libraries#student_libraries_index', :as => 'student_libraries_index'

  get '/restricted' => 'librarians#restricted', :as => 'restricted'
  get '/getBookmarkBooks' => 'books#getBookmarkBooks', :as => 'getBookmarkBooks'
  get '/librarian_book_view' => 'books#librarian_book_view', :as => 'librarian_book_view'
  get '/books_students' => 'books#books_students', :as => 'books_students'
  get '/list_checkedoutBooks' => 'books#list_checkedoutBooks', :as => 'list_checkedoutBooks'
  get '/list_checkedoutBooksAndStudentsAdmin' => 'books#list_checkedoutBooksAndStudentsAdmin', :as => 'list_checkedoutBooksAndStudentsAdmin'
  get '/show_librarians' => 'admins#show_librarians', :as => 'show_librarians'
  get '/show_students' => 'admins#show_students', :as => 'show_students'
  get '/show_books' => 'admins#show_books', :as => 'show_books'
  get '/show_libraries' => 'admins#show_libraries', :as => 'show_libraries'
  get '/add_books' => 'books#new', :as => 'add_books'
  get '/add_students' => 'students#new', :as => 'add_students'
  get '/add_librarians' => 'librarians#new', :as => 'add_librarians'
  get '/getStudentBookFine' => 'books#getStudentBookFine', :as => 'getStudentBookFine'
  get '/getOverdueBooks' => 'books#getOverdueBooks', :as => 'getOverdueBooks'
  get '/viewBookHistory' => 'books#viewBookHistory', :as => 'viewBookHistory'
  get '/viewHoldRequestForLibrarian' => 'books#viewHoldRequestForLibrarian', :as => 'viewHoldRequestForLibrarian'
  get '/viewHoldRequestForAdmin' => 'books#viewHoldRequestForAdmin', :as => 'viewHoldRequestForAdmin'
  get '/librarian_special_book' => 'books#librarian_special_book', :as => 'librarian_special_book'
  get '/reject_special_book' => 'books#reject_special_book', :as => 'reject_special_book'
  get '/approve_special_book' => 'books#approve_special_book', :as => 'approve_special_book'
  
end
