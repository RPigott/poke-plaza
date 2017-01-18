class Pokemon < ApplicationRecord
	belongs_to :species
	belongs_to :user
end
