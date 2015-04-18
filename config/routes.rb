Rails.application.routes.draw do
  scope 'responders/' do
    post '/' => 'responders#create'
  end
end
