class Pet < ApplicationRecord
  SPECIES = %w(dog cat bird horse)

  validates :name, presence: true
  validates :species, inclusion: { in: SPECIES }
end
