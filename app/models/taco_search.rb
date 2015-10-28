class TacoSearch < ActiveRecord::Base
  def self.tacos
  	sql = "SELECT * from tacos"

  	tacos = records_array = ActiveRecord::Base.connection.execute(sql)

  	tacos.map do |taco|
  		OpenStruct.new(taco)
  	end
  end

   def self.salsas
  	sql = "SELECT * from salsas"
  	
  	salsas = records_array = ActiveRecord::Base.connection.execute(sql)

  	salsas.map do |salsa|
  		OpenStruct.new(salsa)
  	end
  end
end
