class TacoSearchController < ApplicationController
	def index
		@tacos = TacoSearch.tacos
		@salsas = TacoSearch.salsas
	end

	def search
		if params[:taco_id] || params[:salsa_id]
			@stores = TacoSearch.search_stores(params[:taco_id],params[:salsa_id])
		else
			redirect_to root_path
		end
	end

end
