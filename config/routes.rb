Rails.application.routes.draw do
  get   '/courses'        => 'courses#index'
  post  '/enrollment/register' => 'enrollments#create'
  get   '/users/courses'     => 'users#courses'
  # Home controller routes.
  root   'home#index'
  get    'auth'            => 'home#auth'

  # Get login token from Knock
  post   'user_token'      => 'user_token#create'

  # User actions
  get    '/users'          => 'users#index'
  get    '/users/current'  => 'users#current'
  get    '/users/all'     => 'users#all'
  post   '/users/create'   => 'users#create'
  patch  '/user/:id'       => 'users#update'
  delete '/user/:id'       => 'users#destroy'
end
