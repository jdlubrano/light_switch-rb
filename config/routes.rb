LightSwitch::Engine.routes.draw do
  resources :switches, only: %i[index update destroy]
end
