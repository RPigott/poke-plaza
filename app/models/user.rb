class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :pokemons
	
	# before_destroy :destroy_pokemons

	def email_required?
		false
	end

	def email_changed?
		false
	end
end
