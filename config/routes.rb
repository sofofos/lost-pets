Rails.application.routes.draw do
  # 🏠 ROOT ROUTE: What users see when they visit "/"
  # Directs to the pets index page (list of all pets)
  root to: "pets#index"

  # 🛣️ RESOURCES: The Rails magic word!
  # This ONE line creates ALL 7 RESTful routes for us:
  #
  # HTTP Verb | Path              | Controller#Action | Purpose
  # ---------------------------------------------------------------
  # GET       | /pets             | pets#index        | List all pets
  # GET       | /pets/:id         | pets#show         | Show one pet
  # GET       | /pets/new         | pets#new          | Form to create pet
  # POST      | /pets             | pets#create       | Save new pet
  # GET       | /pets/:id/edit    | pets#edit         | Form to update pet
  # PATCH/PUT | /pets/:id         | pets#update       | Update existing pet
  # DELETE    | /pets/:id         | pets#destroy      | Delete pet
  #
  # 💡 TIP: Run 'rails routes' in terminal to see all routes!
  resources :pets
end
