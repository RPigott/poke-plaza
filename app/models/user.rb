class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	has_many :pokemons
	has_many :my_notes, foreign_key: :poster_id, class_name: "Note"
	has_many :notes, foreign_key: :postee_id, class_name: "Note"
	
	before_destroy :destroy_pokemons
	
	def to_param
		username
	end

	def email_required?
		false
	end

	def email_changed?
		false
	end
end
