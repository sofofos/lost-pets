class PetsController < ApplicationController
  # 🎯 APPLICATIVE BRICK: The Controller handles user requests

  # 🔄 CALLBACK: DRY (Don't Repeat Yourself) principle in action!
  # This runs set_pet method BEFORE the specified actions
  # Instead of writing @pet = Pet.find(params[:id]) 4 times, we write it once!
  before_action :set_pet, only: [:show, :edit, :update, :destroy]

  # ===================================
  # 📖 READ ACTIONS (GET requests)
  # ===================================

  # INDEX: List all pets
  # Route: GET /pets
  # Purpose: Show all found pets to users
  def index
    @pets = Pet.all  # ActiveRecord method to fetch ALL records from database
  end

  # SHOW: Display one specific pet
  # Route: GET /pets/:id
  # Purpose: Show details about a single pet
  # Note: @pet is set by the before_action callback
  def show
    # @pet is already set by before_action :set_pet
  end

  # ===================================
  # ✏️ CREATE ACTIONS (2-step process!)
  # ===================================

  # NEW: Serves the form to create a pet
  # Route: GET /pets/new
  # Purpose: Display an empty form to the user
  def new
    @pet = Pet.new  # Creates an empty Pet object (not saved to DB yet!)
    # This empty object is needed for form_with to know what model we're using
  end

  # CREATE: Actually saves the pet to database
  # Route: POST /pets
  # Purpose: Receive form data and save the new pet
  def create
    @pet = Pet.new(pet_params)  # Build a new pet with SAFE params from the form

    if @pet.save  # Try to save (validations run here!)
      # ✅ SUCCESS - Pet saved! Redirect to show page
      redirect_to pet_path(@pet)
    else
      # ❌ FAILURE - Validations failed, show the form again with errors
      # We use 'render' not 'redirect' to keep the @pet object with error messages
      render "new", status: :unprocessable_entity
    end
  end

  # ===================================
  # 🔄 UPDATE ACTIONS (2-step process!)
  # ===================================

  # EDIT: Serves the form to update a pet
  # Route: GET /pets/:id/edit
  # Purpose: Display a pre-filled form with existing pet data
  def edit
    # @pet is already set by before_action :set_pet
    # The form will automatically populate with @pet's existing data
  end

  # UPDATE: Actually updates the pet in database
  # Route: PATCH /pets/:id (or PUT)
  # Purpose: Receive form data and update the existing pet
  def update
    if @pet.update(pet_params)  # Try to update with new params (validations run!)
      # ✅ SUCCESS - Pet updated! Redirect to show page
      redirect_to pet_path(@pet)
    else
      # ❌ FAILURE - Validations failed, show the form again with errors
      render "edit", status: :unprocessable_entity
    end
  end

  # ===================================
  # 🗑️ DELETE ACTION
  # ===================================

  # DESTROY: Delete a pet from database
  # Route: DELETE /pets/:id
  # Purpose: Remove a pet record completely
  def destroy
    @pet.destroy  # ActiveRecord method to delete the record
    # Redirect back to the list of all pets
    # status: :see_other tells Turbo to use GET for the redirect
    redirect_to pets_path, status: :see_other
  end

  # ===================================
  # 🔒 PRIVATE METHODS
  # ===================================

  private

  # STRONG PARAMETERS: Security feature!
  # Only allows these specific attributes to be saved
  # Protects against malicious users sending unexpected data
  def pet_params
    # params looks like: { pet: { name: "Snoopy", address: "...", ... } }
    params.require(:pet).permit(:name, :address, :species, :found_on)
  end

  # Helper method to find and set @pet
  # Called by before_action for show, edit, update, destroy
  def set_pet
    @pet = Pet.find(params[:id])  # params[:id] comes from the URL
  end
end
