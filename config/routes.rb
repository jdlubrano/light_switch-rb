LightSwitch::Engine.routes.draw do
  resources :switches, except: %i[edit show]

  root "switches#index"
end
