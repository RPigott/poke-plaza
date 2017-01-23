class Trade < ApplicationRecord
	belongs_to :note

	has_and_belongs_to_many :offered,
							:join_table => :offered_id,
							:foreign_key => :trade_id,
							:association_foreign_key => :offered_id,
							:class_name => "Pokemon"

	has_and_belogns_to_many :requested,
							:join_table => :requested,
							:foreign_key => :trade_id,
							:association_foreign_key => :offered_id,
							:class_name => "Pokemon"
end
