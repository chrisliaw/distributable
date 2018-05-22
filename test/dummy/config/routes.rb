Rails.application.routes.draw do
  mount Distributable::Engine => "/distributable"
end
