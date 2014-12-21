class AddConvTimeToLifecycles < ActiveRecord::Migration
  def up
	  change_table :lifecycle_stages do |t|
		  t.float :conv_time
	  end

		noPurchase = 336262.28849902534
		onePurchase = 459760.41401273885
		repeat = 344243.6551724138
		loyal = 344243.6551724138	  

		LifecycleStage.find(1) do |i| i.conv_time = noPurchase; i.save end
		LifecycleStage.find(2) do |i| i.conv_time = onePurchase; i.save end
		LifecycleStage.find(3) do |i| i.conv_time = repeat; i.save end
		LifecycleStage.find(4) do |i| i.conv_time = loyal; i.save end
  end
  
  def down
	  remove_column :lifecycle_stages, :conv_time
  end
end

