class TacoSearchController < ApplicationController
	def index
		@tacos = TacoSearch.tacos
		@salsas = TacoSearch.salsas
	end
end
