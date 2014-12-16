class BuycycleLifecycle < ActiveRecord::Base
	belongs_to :buycycle_stage
	belongs_to :lifecycle_stage
end
