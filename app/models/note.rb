class Note < ApplicationRecord
	belongs_to :poster, class_name: "User"
	belongs_to :postee, class_name: "User"

	has_many :trades
end
