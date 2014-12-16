class BuycycleStage < ActiveRecord::Base
	has_many :customers
	has_many :lifecycle_stages, :through => :buycycle_lifecycles
end
