class State < ActiveRecord::Base
	has_many :cites
	belongs_to :country
end
