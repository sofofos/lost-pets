class Pet < ApplicationRecord
  # 🎯 DATA BRICK: This is where we start every Rails app!
  # The model represents our database table and contains business logic

  # 📋 Creating a constant array of valid species
  # This can be accessed anywhere as Pet::SPECIES
  # Using %w() is a shorthand for creating an array of strings
  SPECIES = %w(dog cat bird horse)

  # ✅ VALIDATIONS: Protecting our database from bad data
  # These run BEFORE saving to the database

  # Ensures every pet has a name - can't be blank or nil
  validates :name, presence: true

  # Ensures species is one of the options in our SPECIES array
  # This keeps our data clean and prevents typos like "dgo" or "catt"
  validates :species, inclusion: { in: SPECIES }

  # 💡 TIP: Test your validations in rails console!
  # Try: Pet.create(name: "", species: "unicorn")
  # It should fail validation and not save to the database
end
