class StarburstController < ApplicationController
	@@jsonfile = File.read('app/assets/javascripts/starburst_data.json')
  def index
#	@@jsonfile = File.read('app/assets/javascripts/starburst-data.json')
# 	newHash = JSON.parse(jsonfile)

#	render :json => @@jsonfile
		
	respond_to do |format|
		format.html
		format.json { render :json => @@jsonfile  }

	end
	


  end
end
