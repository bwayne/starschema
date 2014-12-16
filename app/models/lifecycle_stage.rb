class LifecycleStage < ActiveRecord::Base
	has_many :customers
	has_many :orders
	has_many :buycycle_stages, :through => :buycycle_lifecycles
end
