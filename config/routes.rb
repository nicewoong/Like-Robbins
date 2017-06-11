Rails.application.routes.draw do
  #This is ROUTES
  
  root 'home#index' #main page
  
  get '/home/index' => 'home#index' #Go to main page
  get '/index' => 'home#index'
  get '/home/versus' => 'home#versus' # Go to thet start of ice-cream selection
  get '/home/versus/choose_one/:chosen_side/:removeIndex' => 'home#choose_one' #아이스크림 하나 선택할 때 마다 액션 수행 
  get '/home/final_choice_pint' => 'home#final_choice_pint' #sorry 에서 하나 제외하고 최종 세 개 final_choice_pint.html로 이동할 거에요. 
  get '/all_icecream' => 'home#all_icecream'
   get '/developer' => 'home#developer'
end
