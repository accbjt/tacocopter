class TacoSearch < ActiveRecord::Base
  def self.tacos
  	sql = "SELECT * from tacos"
  	get_all_data(sql)
  end

  def self.salsas
  	sql = "SELECT * from salsas"
  	get_all_data(sql)
  end

  def self.get_all_data(query)
  	
  	records = ActiveRecord::Base.connection.execute(query)

  	records.map do |record|
  		OpenStruct.new(record)
  	end
  end

  def self.search_stores(tacos,salsas)
  	if tacos && salsas
  		self.search_stores_by_all_categories(tacos,salsas)
  	elsif tacos
  		self.search_store_by_category(tacos)
		elsif salsas
			self.search_store_by_category(salsas)
  	end
  end

  def self.search_store_by_category(category)

  	sql = 'SELECT store_id FROM stores_tacos 
					 WHERE taco_id IN ('+category.join(",")+')
					 GROUP BY store_id
					 HAVING COUNT(store_id) = '+category.count.to_s

		store_id_array = get_all_data(sql).map(&:store_id)

		store_id_array.any? ? self.store_city_query(store_id_array) : store_id_array
  end

  def self.search_stores_by_all_categories(tacos,salsas)

  	sql = 'SELECT t1.store_id, t2.store_id
					 FROM (SELECT store_id FROM stores_tacos 
					 WHERE taco_id IN ('+tacos.join(",")+')
					 GROUP BY store_id
					 HAVING COUNT(store_id) = '+tacos.count.to_s+') t1
					 INNER JOIN
					 (SELECT store_id
				   FROM stores_salsas
					 WHERE salsa_id IN ('+salsas.join(",")+')
					 GROUP BY store_id
					 HAVING COUNT(store_id) = '+salsas.count.to_s+') t2
					 ON t1.store_id = t2.store_id'

		store_id_array = get_all_data(sql).map(&:store_id)

		store_id_array.any? ? self.store_city_query(store_id_array) : store_id_array
  end

  def self.store_city_query(stores)
  	sql = 'SELECT t1.id, t1.name, t2.name city_name
  				 FROM stores t1
           INNER JOIN cities t2 on t1.city_id = t2.id 
           WHERE t1.id in ('+stores.join(",")+')'

    get_all_data(sql)
  end
end
